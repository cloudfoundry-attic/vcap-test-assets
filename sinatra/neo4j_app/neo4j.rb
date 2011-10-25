require 'rubygems'
require 'sinatra'
require 'neography'
require 'json'

include Neography

configure do
  set :show_exceptions, false
end

def get_neo
  begin
    if ENV['VCAP_SERVICES']
      services = JSON.parse(ENV['VCAP_SERVICES'])
      neo4j = services['neo4j-1.4'][0]['credentials']
    else
      neo4j = {}
    end
#$stderr.puts ENV['VCAP_SERVICES']

    Neography::Config.server = neo4j['hostname'] || 'localhost'
    Neography::Config.port =  (neo4j['port'] || "7474").to_i
    Neography::Config.authentication = 'basic'
    Neography::Config.username = neo4j['username']||"test"
    Neography::Config.password = neo4j['password']||"test"

    @neo = Rest.new
#$stderr.puts @neo.configuration
    @neo
  rescue Exception => e
    $stderr.puts "Neo4j Exception #{e}"
    nil
  end
end

before do
  get_neo
end

get '/healthcheck' do
  begin
    Node::load(0)
    "OK"
  rescue Exception => e
    "FAIL: #{ENV['VCAP_SERVICES']} #{e}"
  end
end

def get_root
  Node::load(0)
end

def new_node(question,answer)
  nil unless question && answer
  node = Node.create("answer" => answer, "question" => question)
  get_root.outgoing(:ANSWER) << node
  node
end


get '/' do
  "<h2>Add a Q&amp;A!</h2>" +
    "<form method='post' action='/add'>Question: <input name=question/> Answer: <input type=text name=answer/><input type=submit/></form>" +
    "<h1>Answers from Neo4j!</h1>" +
    "<dl>" +
   get_root.outgoing(:ANSWER).collect { |n| "<dt>Question: #{n.question}</dt><dd>Answer: #{n.answer}</dd>"}.join +
    "</dl>"
end

get '/question', :provides => :json do
  content_type :json
  get_root.outgoing(:ANSWER).collect{ |n| { :question => n.question, :answer => n.answer}}.to_json
end

get '/question/:id', :provides => :json do |id|
  content_type :json
  node = Node::load(id)
  404 unless node
  { :question => node.question, :answer => node.answer}.to_json
end

post '/question' do
  data = JSON.parse request.body.read
  node = new_node(data['question'],data['answer'])
  status 400 unless node
  url("/question/#{node.neo_id}")
end

post '/add' do
  node = new_node(params[:question],params[:answer])
  halt 400 unless node
  redirect to("/"), 201
end

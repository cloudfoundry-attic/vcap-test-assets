require 'sinatra'

get '/eat/ram' do
  n = params['n'].to_i
  generate_data n
end

get '/eat/disk' do
  n = params['n'].to_i
  `dd if=/dev/zero of=testfile1 bs=1000000 count=#{n}`
end

def generate_data(size)
  b = size * 1024 * 1024
  c = [('a'..'z'),('A'..'Z')].map{|i| Array(i)}.flatten
  (0..b).map{c[rand(c.size)]}.join
  return ''
end

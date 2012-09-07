require 'rubygems'
require 'sinatra'
require 'tempfile'

DEFAULT_FILE_SIZE_MB = 25
KB = 1024
MB = KB * 1024

get '/' do
  host = ENV['VCAP_APP_HOST']
  port = ENV['VCAP_APP_PORT']
  msg = "<h1>Hello from DiskHog! via: #{host}:#{port} </h1>"
  msg += "<h2>Visit /largefile to trigger bad behavior</h2>"
end

def random_str(size)
 File.open('/dev/urandom') { |x| x.read(size).unpack('H*')[0] }
end

# GET /largefile
# create a file of size DEFAULT_FILE_SIZE_MB
#
# To create a file size other than default, pass 'size' as a param.
# E.g., to create a 10MB file:
#   curl '<myapp>/largefile?size=10'

get '/largefile' do
  size_in_mb = params[:size].to_i
  size_in_mb = DEFAULT_FILE_SIZE_MB unless size_in_mb > 0
  kbytes = size_in_mb * KB

  # if sinatra < 1.3
  # Note: large files may fail due to gateway timeout
  # use Tempfile to generate a temporary file name.  We can't use
  # the Tempfile itself since it will will be deleted when the
  # process ends
  tmp = Tempfile.new("garbage", ".")
  fname = File.basename(tmp.path)
  tmp.unlink
  File.open(fname, 'w') do |f|
   # write out chunks of KB bytes
    (1..kbytes).each { f.write(random_str(KB)) }
  end

  # if sinatra >= 1.3
  # we need to stream the response lest CF think something's amiss
  # and returns the dreaded "504 timeout"
  #stream do |out|
  #  File.open('garbage', 'w') do |f|
      # write out chunks of KB bytes
  #    (1..kbytes).each { f.write(random_str(KB)) }
  #    out << '.'
  #  end
  #  out << "\nwrote #{kbytes*KB} bytes to #{fname} (#{size_in_mb}MB)\n"
  #end
  "wrote #{kbytes*KB} bytes to 'garbage' (#{size_in_mb}MB)\n"
end

require 'net/http'
require 'net/https'
require 'uri'
require 'time'
require 'openssl'
require 'base64'

# A very simple Atmos client which focus on basic file operations
# using namespace method.
class AtmosClient
  include Digest
  include OpenSSL

  REQUIRED_OPTS = %w(url sid uid key)
  HEADERS = {
    :date => 'date',
    :emc_date => 'x-emc-date',
    :sign => 'x-emc-signature',
    :uid => 'x-emc-uid',
    :type => 'content-type',
    :extent => 'Extent',
  }
  def initialize(opts)
    @opts = opts
    host = opts[:host]
    # default 80
    port = opts[:port].to_i || 80
    @http = Net::HTTP.new(host, port)
    @http.use_ssl = true if (port == 443 || port == 10080)
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  def get_obj_ns(path='')
    path = '/rest/namespace/'+ path
    req = Net::HTTP::Get.new(path)
    send_request(req)
  end

  def get_obj(id)
    return unless id
    req = Net::HTTP::Get.new(id)
    send_request(req)
  end

  def create_obj_ns(path='', content=nil)
    path = '/rest/namespace/'+ path
    req = Net::HTTP::Post.new(path)
    req.body = content
    send_request(req)
  end

  def create_obj(content=nil)
    req = Net::HTTP::Post.new('/rest/objects')
    req.body = content
    send_request(req)
  end

  def delete_obj_ns(path='')
    path = '/rest/namespace/'+ path
    req = Net::HTTP::Delete.new(path)
    send_request(req)
  end

  def delete_obj(id)
    return unless id
    req = Net::HTTP::Delete.new(id)
    send_request(req)
  end

protected

  def send_request(req)
    prepare_request(req)
    res = @http.start do |http|
      http.request(req)
    end
    return res
  end

  def prepare_request(request)
    t = Time.now.httpdate
    request[HEADERS[:emc_date]] = t
    request[HEADERS[:date]] = t
    request[HEADERS[:type]]= 'application/octet-stream'
    request[HEADERS[:uid]]= "#{@opts[:sid]}/#{@opts[:uid]}"
    request[HEADERS[:sign]] = gen_auth_header(request)
  end

  def gen_auth_header(request)
    hash_string = "#{request.method}\n"+
      "#{request[HEADERS[:type]]}\n" +
      "#{request[HEADERS[:extent]]}\n"+
      "#{request[HEADERS[:date]]}\n"+
      "#{request.path.downcase}\n"

    custom_args = {}
    request.each_header{ |key, value|
      if key =~ /^x-emc-/
        custom_args[key] = value
      end
    }
    custom_args = custom_args.sort()
    custom_headers = ""
    custom_args.each{ |key, value|
      custom_headers += key + ":" + value.lstrip.rstrip + "\n"
    }

    custom_headers = custom_headers.chomp()
    hash_string += custom_headers
    digest = HMAC.digest(OpenSSL::Digest.new('sha1'), Base64.decode64(@opts[:key]), hash_string)
    Base64.encode64(digest.to_s).chomp
  end
end

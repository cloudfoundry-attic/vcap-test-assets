require 'sinatra'
require 'socket'
require 'timeout'

get '/:ip/:port' do |ip, port|
  if is_port_open?(ip, port)
    "#{ip}:#{port} is open"
  else
    "#{ip}:#{port} is NOT open"
  end
end

def is_port_open?(ip, port)
  begin
    Timeout::timeout(10) do
      begin
        s = TCPSocket.new(ip, port)
        s.close
        return true
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        return false
      end
    end
  rescue Timeout::Error
  end

  return false
end
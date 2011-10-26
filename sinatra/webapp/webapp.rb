# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'sinatra'

# Big string for us to carve up and return
$k_string = ""

configure do
  1024.times{$k_string  << (65 + rand(25)).chr}
end

# dummy request returning a single byte
get '/' do
  '/'
end

# sleep url
get '/sleep/:time' do
   start = Time.now
   time = params[:time].to_f
   sleep (time/1000)
   etime = Time.now - start
   "Slept for #{etime.to_f}"
end

# memory intensive url
get '/mem/:mem/:time' do
  size = params[:mem].to_i
  time = params[:time].to_f
  buf = Array.new(size)
  endTime = Time.now + (time/1000)
  while Time.now < endTime
     (0..size).step(2048) {|x| buf[x] = rand(1000000000)}
  end
  "Processed array length #{size} time #{params[:time].to_i}"
end

# IO intensive url
get '/io/:kb' do
   kbs = params[:kb].to_i
   str = ""
   kbs.times { str += $k_string }
   str
end

# CPU intensive url (dummy loop to compute pi)
get '/cpu/:digit' do
   num = 4.0
   pi = 0
   plus = true
   accuracy = params[:digit].to_i
   den = 1
   while den < accuracy
      if plus
         pi = pi + num/den
         plus = false
      else
         pi = pi - num/den
         plus = true
      end
      den = den + 2
   end
   "PI #{accuracy} --> #{pi}"
end

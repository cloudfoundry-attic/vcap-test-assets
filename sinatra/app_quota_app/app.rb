require 'sinatra'
require 'json'

MILLION         = 1 * 1024 * 1024
LARGE_INTEGER   = 2 ** 64
BASE36_ENCODE   = 36

MAX_WORKERS     = 10
MAX_DIRECTORIES = 10

SIXTY_SECONDES  = 60

$data = {}

get '/data' do
  $data.to_json
end

delete '/data' do
  n = params['n'].to_i
  n = 1 if n < 1
  n.times do
    key = $data.keys.first
    case $data[key]
      when File
        $data[key].close
      else
        # do nothing
    end
    $data.delete(key)
  end
end

get '/eat/ram' do
  n = params['n'].to_i
  generate_data(n)
  puts "generate #{n}MB data"
end

get '/eat/disk' do
  n = params['n'].to_i
  n = 1 if n < 1
  src_file = File.join(Dir.pwd, "tempfile")
  puts `dd if=/dev/urandom of=#{src_file} bs=1M count=1`

  queue = Queue.new
  n.times do |job|
    queue << job
  end

  MAX_DIRECTORIES.times do |index|
    Dir.mkdir(index.to_s) unless Dir.exist?(index.to_s)
  end

  # 10 concurrent workers generate n MB datas
  threads = []
  MAX_WORKERS.times do
    threads << Thread.new do
      until queue.empty?
        job = queue.pop
        dirname = (job % MAX_DIRECTORIES).to_s
        FileUtils.cp(src_file, File.join(Dir.pwd, dirname, rand_str))
      end
    end
  end
  threads.each { |t| t.join }
  FileUtils.rm(src_file)
  puts "generate #{n}MB files"
end

get '/fds' do
  data = {}
  results = `lsof -p #{Process.pid}`.split("\n")
  data[:count] = results.length
  data[:details] = results
  data.each do |k, v|
    puts k
    if v.class == Array
      v.each { |item| puts item}
    else
      puts v
    end
  end
  data.to_json
end

get '/allocate/fds' do
  n = params['n'].to_i
  n = 1 if n < 1
  src_file = File.join(Dir.pwd, "tempfile")
  puts `dd if=/dev/urandom of=#{src_file} bs=1b count=1`

  queue = Queue.new
  n.times do |job|
    queue << job
  end

  MAX_DIRECTORIES.times do |index|
    Dir.mkdir(index.to_s) unless Dir.exist?(index.to_s)
  end

  # 10 concurrent workers to allocate file descriptor
  threads = []
  lock = Mutex.new
  MAX_WORKERS.times do
    threads << Thread.new do
      until queue.empty?
        job = queue.pop
        dirname = (job % MAX_DIRECTORIES).to_s
        filename = rand_str
        filepath = File.join(Dir.pwd, dirname, rand_str)
        begin
          FileUtils.cp(src_file, filepath)
          lock.synchronize do
            $data[filename] = open(filepath)
          end
        rescue Exception => e
          puts e.to_s
          break
        end
      end
    end
  end
  threads.each { |t| t.join }
  FileUtils.rm(src_file)
  puts "allocate #{n} file descriptors"
end

get '/allocate/process' do
  n = params['n'].to_i
  n = 1 if n < 1
  $data[:theads] = Queue.new
  n.times do
    begin
      $data[:theads] << Thread.new do
        sleep(60)
      end
    rescue Exception => e
      puts e.to_s
      break
    end
  end
  "allocate #{n} threads"
end

def generate_data(size)
  size = 1 if size < 1
  (1..size).to_a.each do |index|
    # generate 1MB data
    key = rand_str
    $data[key] = key * (MILLION / key.length) + key[1..(MILLION % key.length)]
  end
end

def rand_str
  rand(LARGE_INTEGER).to_s(BASE36_ENCODE)
end

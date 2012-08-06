require 'sinatra'

MILLION         = 1 * 1024 * 1024
LARGE_INTEGER   = 2 ** 64
BASE36_ENCODE   = 36

MAX_WORKERS     = 10
MAX_DIRECTORIES = 10

$data = {}

get '/data' do
  $data.keys.to_s
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

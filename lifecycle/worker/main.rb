INCREMENT = 0.5.freeze

i = 0
loop do
  i += INCREMENT
  sleep(INCREMENT)
  $stdout.puts "running for #{i} secs"
  $stdout.flush
end

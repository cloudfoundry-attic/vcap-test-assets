[5, 10, 15, 20].each do |total|
  sleep(5)
  $stdout.puts "running for #{total} secs"
  $stdout.flush
end

while true
  sleep(10)
  $stdout.puts "still running..."
  $stdout.flush
end

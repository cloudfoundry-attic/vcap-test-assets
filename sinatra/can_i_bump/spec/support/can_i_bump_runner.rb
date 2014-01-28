module CanIBumpRunner
  PORT = 8181
  START_TIMEOUT = 20
  SLEEP_INTERVAL = 0.5

  def app_url
    "http://127.0.0.1:#{PORT}"
  end

  def start_can_i_bump(opts = {})
    cmd = "bundle exec rackup config.ru -p #{PORT}"
    @app_pid = run_cmd(cmd, opts)

    Integer(START_TIMEOUT/SLEEP_INTERVAL).times do
      sleep SLEEP_INTERVAL
      result =make_get_request rescue nil
      return if result && result.code.to_i == 200
    end

    raise "App did not start up after #{START_TIMEOUT}s"
  end

  def stop_can_i_bump
    graceful_kill(@app_pid)
  end

  def make_get_request
    RestClient.get app_url
  end

  def make_put_request(path)
    RestClient.put("#{app_url}/#{path}", "")
  end

  private

  def run_cmd(cmd, opts={})
    project_path = File.join(File.dirname(__FILE__), "../..")
    spawn_opts = {
      :chdir => project_path,
      :out => opts[:debug] ? :out : "/dev/null",
      :err => opts[:debug] ? :out : "/dev/null",
    }

    Process.spawn(opts[:env], cmd, spawn_opts)
  end

  def graceful_kill(pid)
    Process.kill("TERM", pid)
    Timeout::timeout(1) do
      Process.wait(pid)
    end
  rescue Timeout::Error
    Process.detach(pid)
    Process.kill("KILL", pid)
  rescue Errno::ESRCH
    true
  end
end
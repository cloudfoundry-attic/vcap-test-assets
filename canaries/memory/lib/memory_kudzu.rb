class MemoryKudzu
  class << self
    def memory_size
      system_ps_call.strip.split.map(&:to_i).last.to_f / 1024
    end

    def grow_until(size_in_mb)
      @vine ||= []
      while (memory_size < size_in_mb)
        #puts "memory_size: #{memory_size} size_in_mb: #{size_in_mb}"
        @vine << (rand.to_s * 10**5).to_sym
      end
    end

    private
    def system_ps_call
      `ps ax -o pid,rss | grep -E "^[[:space:]]*#{$$}"`
    end
  end
end
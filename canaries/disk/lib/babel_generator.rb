require 'sys/filesystem'

class BabelGenerator
  CHARS = ('a'..'z').to_a << ' ' << '.' << "\n"

  def initialize(dir)
    @dir = dir
    stat = Sys::Filesystem.stat('/')
    @avail_space = stat.blocks_free * stat.block_size / 1024**2
  end

  def cleanup
    `rm #{@dir}/SPACE*.txt`
  end

  def populate_until(size_in_mb)
    while space_used < size_in_mb
      generate_file(100)
    end
  end

  private
  def random_char
    CHARS[(CHARS.size*rand).floor]
  end

  def space_used
    stat = Sys::Filesystem.stat('/')
    @avail_space - (stat.block_size * stat.blocks_free / 1024**2)
  end

  def generate_babel(size)
    text = ''
    size.times do
      text+=random_char
    end
    text
  end

  def generate_file(size)
    f = File.new("#{@dir}/SPACE#{((2**30 - 1)*rand).floor}.txt", "w+")
    (size).times do
      f.write(generate_babel(1024)*1024)
    end
    f.close()
  end
end
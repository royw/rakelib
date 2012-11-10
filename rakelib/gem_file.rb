require 'fileutils'

class GemFile
  def initialize
    @header = []
    @dev_body = []
    @footer = []
  end

  def load(filename)
    @filename = filename
    mode = :in_header
    IO.readlines(@filename).each do |line|
      case mode
        when :in_header
          mode = :in_dev_body if line =~ %r{^\s*group\s+:development\s+do}
          @header << line
        when :in_dev_body
          if line =~ %r{^\s*end}
            mode = :in_footer
            @footer << line
          else
            @dev_body << line
          end
        when :in_footer
          @footer << line
      end
    end
  end

  def dev_gems=(gems)
    @dev_body = gems.map{|gem| "  #{gem}"}
  end

  def save(filename=@filename)
    backup_filename = filename + '~'
    File.delete(backup_filename) if File.exist? backup_filename
    FileUtils.mv(filename, backup_filename)
    File.open(filename, 'w') do |f|
      f.puts @header
      f.puts @dev_body
      f.puts @footer
    end
  end
end

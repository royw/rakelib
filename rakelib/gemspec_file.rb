require 'fileutils'

class GemspecFile
  def initialize
    @header = []
    @body = []
    @dev_dependencies = []
    @footer = []
  end

  def load(filename)
    @filename = filename
    mode = :in_header
    IO.readlines(@filename).each do |line|
      case mode
        when :in_header
          if line =~ %r{^\s*gem\.}
            mode = :in_dev_body
            if line =~ %r{^\s*gem\.add_development_dependency}
              @dev_dependencies << line
            else
              @body << line
            end
          else
            @header << line
          end
        when :in_dev_body
          if line =~ %r{^\s*end}
            mode = :in_footer
            @footer << line
          else
            if line =~ %r{^\s*gem\.add_development_dependency}
              @dev_dependencies << line
            else
              @body << line
            end
          end
        when :in_footer
          @footer << line
      end
    end
  end

  def dev_gems=(gems)
    @dev_dependencies = gems.map{|gem| "  #{gem}"}
  end

  def save(filename=@filename)
    backup_filename = filename + '~'
    File.delete(backup_filename) if File.exist? backup_filename
    FileUtils.mv(filename, backup_filename)
    File.open(filename, 'w') do |f|
      f.puts @header
      f.puts @body
      f.puts @dev_dependencies
      f.puts @footer
    end
  end
end

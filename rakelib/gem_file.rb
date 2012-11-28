require 'fileutils'

# Encapsulation for modifying the GemFile
# The GemFile is split into three sections: @header, @dev_body, and @footer.
# This is to facilitate updating (replacing) the development gem commands.
class GemFile
  def initialize
    @header = []
    @dev_body = []
    @footer = []
  end

  # Load the given GemFile
  # @param [#to_s] filename the path to the GemFile to load
  def load(filename)
    @filename = filename.to_s
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

  # replace the "gem(...)" lines in the development block
  # @param [Array<String>] gems an array of "gem(...)" lines for the development block
  # @return [String] the new @dev_body
  def dev_gems=(gems)
    @dev_body = gems.map{|gem| "  #{gem}"}
  end

  # reassemble the file and save it
  # @param [String] filename the destination GemFile path
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

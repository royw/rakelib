begin
  require 'simplecov'
  require 'simplecov-rcov'

  def coverage_directory
    dir = File.expand_path('../doc/coverage', File.dirname(__FILE__))
    FileUtils.mkdir_p dir
    dir
  end

  class SimpleCov::Formatter::MergedFormatter
    def format(result)
      SimpleCov::Formatter::HTMLFormatter.new.format(result)
      SimpleCov::Formatter::RcovFormatter.new.format(result)
      File.open("#{coverage_directory}/covered_percent", "w") do |f|
        f.puts result.source_files.covered_percent.to_f
      end
    end
  end

  task :simplecov do
    SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter
    SimpleCov.configure do
      coverage_dir 'doc/coverage'
      root File.expand_path('..', File.dirname(__FILE__))
    end
    SimpleCov.start
  end

  # adds simplecov task as a prerequisite to the :spec task
  task :spec => :simplecov
rescue LoadError => ex
  puts "Can not perform code coverage using simplecov.  #{ex.to_s}"
end

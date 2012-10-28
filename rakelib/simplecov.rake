# Simple Coverage tasks for ruby 1.9+ https://github.com/colszowka/simplecov
#
# This will run coverage as part of rspec and cucumber features.
#
# Note that the simplecov task provides the covered_percent file used by cane.rake's quality task.

require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)
# Settings[:coverage_dir]

begin
  require 'simplecov'
  require 'simplecov-rcov'

  def coverage_directory
    dir = File.expand_path(Settings[:coverage_output_dir], Rake.application.original_dir)
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
      coverage_dir Settings[:coverage_output_dir]
      root Rake.application.original_dir
    end
    SimpleCov.start
  end

  # adds simplecov task as a prerequisite to the RSpec and Cucumber tasks
  task :spec => :simplecov
  task :features => :simplecov
rescue LoadError => ex
  puts "Can not perform code coverage using simplecov.  #{ex.to_s}"
end

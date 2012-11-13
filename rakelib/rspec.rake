# RSpec http://rspec.info/

require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)
# Uses these settings:
# * Settings[:test_dirs]
# * Settings[:coverage_output_dir]

# rake rcov                # Run RSpec code examples
# rake spec                # Run RSpec code examples

# for ruby < 1.9
# add to your .gemspec:
#   gem.add_development_dependency('rspec')
#   gem.add_development_dependency('rcov') if RUBY_VERSION =~ %r{^1\.8\.}
# or add to your Gemfile:
#   gem 'rspec'
#   gem 'rcov' if RUBY_VERSION =~ %r{^1\.8\.}
#
# for ruby >= 1.9
#   gem.add_development_dependency('rspec')
#   gem.add_development_dependency('simplecov')  unless RUBY_VERSION =~ %r{^1\.8\.}
#   gem.add_development_dependency('simplecov-rcov')  unless RUBY_VERSION =~ %r{^1\.8\.}
# or add to your Gemfile:
#   gem 'rspec'
#   gem 'simplecov' unless RUBY_VERSION =~ %r{^1\.8\.}
#   gem 'simplecov-rcov' unless RUBY_VERSION =~ %r{^1\.8\.}

begin
  require 'rspec/core'
  require 'rspec/core/rake_task'

  desc 'Remove the generated documentation'
  task :clean do
    puts "removing coverage documentation"
    FileUtils.rm_rf File.expand_path(Settings[:coverage_output_dir], Rake.application.original_dir)
  end

  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.rspec_opts = ["-c", "-f progress"] #, "-r ./spec/spec_helper.rb"]
    spec.pattern = FileList["{#{Settings[:test_dirs].join(',')}}/**/*_spec.rb"]
  end

  begin
    require 'rcov'
    RSpec::Core::RakeTask.new(:rcov) do |spec|
      spec.pattern = FileList["{#{Settings[:test_dirs].join(',')}}/**/*_spec.rb"]
      spec.rcov = true
    end
  rescue LoadError
  end

  namespace :init do
    desc 'Initialize rspec infrastructure'
    task :spec do
      dir = File.expand_path('spec', Rake.application.original_dir)
      FileUtils.mkdir_p dir unless File.exist? dir
      helper_file = File.join(dir, 'spec_helper.rb')
      unless File.exist? helper_file
        File.open(helper_file, 'w') do |f|
          f.puts "$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))"
          f.puts "$LOAD_PATH.unshift(File.dirname(__FILE__))"
          f.puts ""
          f.puts "require '#{Settings[:app_dir]}'"
        end
      end
    end
  end
rescue LoadError
  warn "rspec not available, spec and rcov tasks not provided."
end

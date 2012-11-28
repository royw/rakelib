# Cumcumber http://cukes.info/
# Behavior Driven Development
#
# rake features            # Run Cucumber features
#
# add to your .gemspec:
#   gem.add_development_dependency('cucumber')
# or add to your Gemfile:
#   gem 'cucumber'
#
# Optionally
#

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)

  namespace :init do
    desc 'Initialize cucumber feature infrastructure'
    task :features do
      dir = File.expand_path('features/support', Rake.application.original_dir)
      FileUtils.mkdir_p dir unless File.exist? dir
      env_file = File.join(dir, 'env.rb')
      unless File.exist? env_file
        File.open(env_file, 'w') do |f|
          f.puts "require 'rspec'"
          f.puts "require_relative('../../lib/#{Settings[:app_dir]}')"
        end
      end
    end
  end
rescue LoadError
  warn "cucumber not available, cucumber task not provided."
end

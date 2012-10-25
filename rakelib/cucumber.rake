# Cumcumber http://cukes.info/
# Behavior Driven Development
#
# rake features            # Run Cucumber features

# add to your .gemspec:
#   gem.add_development_dependency('cucumber')
# or add to your Gemfile:
#   gem 'cucumber'

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
rescue LoadError
  warn "cucumber not available, cucumber task not provided."
end

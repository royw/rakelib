# add to your .gemspec:
#   gem.add_development_dependency('cucumber')

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
rescue LoadError
  warn "cucumber not available, cucumber task not provided."
end

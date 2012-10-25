# add to your .gemspec:
#   gem.add_development_dependency('rspec')
# for ruby < 1.9
#   gem.add_development_dependency('rcov')
# for ruby >= 1.9
#   gem.add_development_dependency('simplecov')

begin
  require 'rspec/core'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.rspec_opts = ["-c", "-f progress"] #, "-r ./spec/spec_helper.rb"]
    spec.pattern = FileList['spec/**/*_spec.rb']
  end

  RSpec::Core::RakeTask.new(:rcov) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rcov = true
  end
rescue LoadError
  warn "rspec not available, spec and rcov tasks not provided."
end

# Cane https://github.com/square/cane
# Quality metrics
# Fails your build if code quality thresholds are not met.
#
# rake quality             # Run cane to check quality metrics
#
# Expects code in one or more of these directories:
CANE_CODE_DIRS = %w{ lib app controller model spec }
CANE_DOC_DIRS = %w{ lib app controller model }

# add to your .gemspec:
#   gem.add_development_dependency('cane')
# or add to your Gemfile:
#   gem 'cane'

begin
  require 'cane/rake_task'

  desc "Run cane to check quality metrics"
  Cane::RakeTask.new(:quality) do |cane|
    cane.abc_glob = "{#{CANE_CODE_DIRS.join(',')}}/**/*.rb"
    cane.abc_max = 10
    cane.add_threshold 'coverage/covered_percent', :>=, 90
    cane.no_style = false
    cane.doc_glob = "{#{CANE_DOC_DIRS.join(',')}}/**/*.rb"
    cane.style_glob = "{#{CANE_DOC_DIRS.join(',')}}/**/*.rb"
    #cane.abc_exclude = %w(Foo::Bar.some_method)
  end
rescue LoadError
  warn "cane not available, quality task not provided."
end

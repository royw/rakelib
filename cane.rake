# add to your .gemspec:
#   gem.add_development_dependency('cane')

begin
  require 'cane/rake_task'

  desc "Run cane to check quality metrics"
  Cane::RakeTask.new(:quality) do |cane|
    cane.abc_glob = "{lib,app,controller,model,spec}/**/*.rb"
    cane.abc_max = 10
    cane.add_threshold 'coverage/covered_percent', :>=, 90
    cane.no_style = false
    cane.doc_glob = "{lib,app,controller,model}/**/*.rb"
    cane.style_glob = "{lib,app,controller,model}/**/*.rb"
    #cane.abc_exclude = %w(Foo::Bar.some_method)
  end
rescue LoadError
  warn "cane not available, quality task not provided."
end

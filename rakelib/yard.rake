# YARD documentation http://yardoc.org/

# These tasks are for using the yard documentation system.
# The source files are .rb files in the YARD_SOURCE_DIRS directories.
# The output is placed into your project's doc/app/ directory.
# Any .md.erb files are processed with ERB to create .md files before running yard.
# If you have a README.md file (maybe generated from a README.md.erb file), it is used as the documentations README

# rake clean               # remove the generated documentation
# rake doc                 # generate documentation
# rake markdown_erb        # convert .md.erb documentation to .md
# rake yard                # Generate YARD Documentation

# add to your .gemspec:
#   gem.add_development_dependency('yard')
#   gem.add_development_dependency('redcarpet')
# or add to your Gemfile:
#   gem 'yard'
#   gem 'redcarpet'
#
# if you want syntax highlighting via pygments (http://pygments.org)
# * install pygments
# * add the following to your .gemspec
#     gem.add_development_dependency('yard-pygmentsrb')
#     gem.add_development_dependency('pygments.rb')
#   or add to your Gemfile:
#     gem 'yard-pygmentsrb'
#     gem 'pygments.rb'

# then your markdown can include code fragments like:
# ``` ruby
#   puts 'Howdy!'
# ```

SOURCE_DIRS ||= %w{ lib app controller model }

begin
  require 'yard'
  require 'erb'

  desc 'Remove the generated documentation'
  task :clean do
    puts "removing old documentation"
    FileUtils.rm_rf File.expand_path('doc', File.dirname(__FILE__))
    FileUtils.rm_rf File.expand_path('.yardoc', File.dirname(__FILE__))
  end

  desc 'Convert .md.erb documentation to .md'
  task :markdown_erb do
    Dir['**/*.md.erb'].each do |fn|
      output_file = File.expand_path(fn.gsub(/\.md\.erb$/, '.md'), File.dirname(__FILE__))
      puts "processing: #{fn} to #{output_file}"
      template = ERB.new IO.read(fn)
      File.open(output_file, 'w') {|f| f.puts template.result(binding)}
    end
  end

  YARD::Rake::YardocTask.new do |t|
    t.files = ["{#{SOURCE_DIRS.join(',')}}/**/*.rb"]
    t.options = ['--output-dir', 'doc/app/', '--markup', 'markdown', '--readme', 'README.md']
  end

  desc 'Generate Documentation from .md.erb, .md, .rb'
  task :doc => [:markdown_erb, :yard]
rescue LoadError
  warn "yard or erb not available, yard documentation tasks not provided."
end

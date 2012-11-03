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

require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)
# Uses these settings:
# * Settings[:app_name]
# * Settings[:source_dirs]
# * Settings[:yard_output_dir]


begin
  require 'yard'
  require 'erb'
  require File.expand_path('version.rb', File.dirname(__FILE__))

  desc 'Remove the generated documentation'
  task :clean do
    puts "removing yard documentation"
    FileUtils.rm_rf File.expand_path(Settings[:yard_output_dir], Rake.application.original_dir)
    FileUtils.rm_rf File.expand_path('.yardoc', Rake.application.original_dir)
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
    t.files = ["{#{Settings[:source_dirs].join(',')}}/**/*.rb"]
    t.options = ['--title', "#{Settings[:app_name]} #{Version.version_get}".strip,
                 '--output-dir', Settings[:yard_output_dir],
                 '--markup', 'markdown',
                 '--readme', 'README.md']
  end

  desc 'Generate Documentation from .md.erb, .md, .rb'
  task :doc => [:markdown_erb, :yard]
rescue LoadError
  warn "yard or erb not available, yard documentation tasks not provided."
end

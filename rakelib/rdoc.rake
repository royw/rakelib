# RDoc http://rdoc.rubyforge.org/
# Ruby Documentation System

# Will generate documentation from all .rb files under RDOC_SOURCE_DIRS and
# any README* files and any *.rdoc files.
# If a VERSION or version.rb file exists, will use the version found in the file in the documentation.
# Note, a VERSION file should be a file that contains just a version,
# while version.rb should contain a 'VERSION = "\d\S+"' line.

# The directories that might contain source code to document
RDOC_SOURCE_DIRS = %w{ lib app controller model }

# Will output HTML to the ./rdoc directory

# rake clobber_rdoc        # Remove RDoc HTML files
# rake rdoc                # Build RDoc HTML files
# rake rerdoc              # Rebuild RDoc HTML files

# add to your .gemspec:
#   gem.add_development_dependency('rdoc')
# or add to your Gemfile:
#   gem 'rdoc'


begin
  require 'rdoc/task'

  raise 'APP_NAME constant not set' if APP_NAME.nil?

  Rake::RDocTask.new do |rdoc|
    version = ''
    Dir["**/VERSION"].each do |fn|
      version =  File.read(fn).strip
    end
    Dir["{#{RDOC_SOURCE_DIRS.join(',')}}/**/version.rb"].each do |fn|
      str = IO.read(version_file)
      version = $1 if str =~ /VERSION\s*=\s*\"?(\d\S+)\"?/m
    end

    rdoc.rdoc_dir = 'rdoc'
    rdoc.title = "#{APP_NAME} #{version}".strip
    rdoc.rdoc_files.include('README*')
    rdoc.rdoc_files.include('**/*.rdoc')
    rdoc.rdoc_files.include("{#{RDOC_SOURCE_DIRS.join(',')}}/**/*.rb")
  end
rescue LoadError
  warn "rdoc not available, rdoc tasks not provided."
rescue Exception => ex
  warn "#{ex.to_s}, rdoc tasks not provided."
end

# Version bump tasks
#
# These tasks are for bumping the version in your version.rb file.
#
# Expects a version.rb file in your project that contains a 'VERSION = "\d\S+"' line.

# rake version:bump:patch  # bump the patch version

# add to your .gemspec:
#   gem.add_development_dependency('versionomy')
# or add to your Gemfile:
#   gem 'versionomy'

begin
  require 'versionomy'
  namespace :version do
    namespace :bump do
      desc 'bump the patch version'
      task :patch do
        Dir['**/version.rb'].each do |version_file|
          str = IO.read(version_file)
          if str =~ /VERSION\s*=\s*\"?(\d\S+)\"?/m
            version = Versionomy.parse $1
            old_version = version.to_s
            new_version = version.bump(:tiny).to_s
            File.open(version_file, 'w') {|f| f.puts str.gsub(old_version, new_version)}
            puts "updated version from #{old_version} to #{new_version}"
          end
        end
      end
    end
  end
rescue LoadError
  warn "versionomy not available, version bump tasks not provided."
end

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

VERSION_REGEX = /VERSION\s*=\s*[\"\']?(\d[^\"\']*)[\"\']?/m

begin
  require 'versionomy'
  namespace :version do
    def version_get
      Dir["#{Rake.application.original_dir}/**/version.rb"].each do |version_file|
        str = IO.read(version_file)
        if str =~ VERSION_REGEX
          return $1
        end
      end
      Dir["#{Rake.application.original_dir}/**/VERSION"].each do |version_file|
        return IO.read(version_file).strip
      end
      'not found'
    end

    def version_set(new_version)
      Dir['**/version.rb'].each do |version_file|
        str = IO.read(version_file)
        if str =~ VERSION_REGEX
          old_version = $1
          File.open(version_file, 'w') {|f| f.puts str.gsub(old_version, new_version)}
        end
      end
      Dir['**/VERSION'].each do |version_file|
        File.open(version_file, 'w') {|f| f.puts new_version}
      end
      new_version
    end

    def version_bump(&block)
      old_version = Versionomy.parse version_get
      new_version = block.call(old_version).to_s
      version_set new_version
    end

    desc 'reset version to 0.0.1'
    task :reset do
      puts version_set '0.0.1'
    end

    desc 'get the current version'
    task :get do
      puts version_get
    end

    namespace :bump do
      desc 'bump the major version'
      task :major do
        old_version = version_get
        new_version = version_bump {|version| version.bump(:major)}
        puts "updated version from #{old_version} to #{new_version}"
      end
      desc 'bump the minor version'
      task :minor do
        old_version = version_get
        new_version = version_bump {|version| version.bump(:minor)}
        puts "updated version from #{old_version} to #{new_version}"
      end
      desc 'bump the patch version'
      task :patch do
        old_version = version_get
        new_version = version_bump {|version| version.bump(:tiny)}
        puts "updated version from #{old_version} to #{new_version}"
      end
    end
  end
rescue LoadError
  warn "versionomy not available, version bump tasks not provided."
end

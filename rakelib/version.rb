# This module provides methods for interacting with your version file.  The version
# file may be either the bundler standard of version.rb (which defines a constant VERSION within a module)
# or the jeweler standard of VERSION (which contains just a version number).

require 'versionomy'

require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)
# Uses these settings:
# * Settings[:source_dirs]

module Version
  VERSION_REGEX = /VERSION\s*=\s*[\"\']?(\d[^\"\']*)[\"\']?/m
  def self.versionrb_filenames
    Dir["#{Rake.application.original_dir}/{#{Settings[:source_dirs].join(',')}}/**/version.rb"]
  end

  def self.version_filenames
    Dir["#{Rake.application.original_dir}**/VERSION"]
  end

  def self.version_get
    versionrb_filenames.each do |version_file|
      str = IO.read(version_file)
      if str =~ VERSION_REGEX
        return $1
      end
    end
    version_filenames.each do |version_file|
      return IO.read(version_file).strip
    end
    'not found'
  end

  def self.version_set(new_version)
    versionrb_filenames.each do |version_file|
      str = IO.read(version_file)
      if str =~ VERSION_REGEX
        old_version = $1
        File.open(version_file, 'w') {|f| f.puts str.gsub(old_version, new_version)}
      end
    end
    version_filenames.each do |version_file|
      File.open(version_file, 'w') {|f| f.puts new_version}
    end
    new_version
  end

  def self.version_bump(&block)
    old_version = Versionomy.parse version_get
    new_version = block.call(old_version).to_s
    version_set new_version
  end
end


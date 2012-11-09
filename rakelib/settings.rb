require File.expand_path('rakelib/extension_string.rb', Rake.application.original_dir)

unless defined? Settings
  def self.setting(key, options={})
    Settings[key] = options[:value]
    SettingDescriptions[key] = options[:description]
  end

  Settings = {}
  SettingDescriptions = {}

  setting :app_name, :value => File.basename(File.dirname(File.dirname(__FILE__))).camel_case,
          :description => '[String] the application name'

  setting :source_dirs, :value => %w{ lib app controller model }.select{|dir| File.exist? dir},
          :description => '[Array<String>] the directories that may contain source files to be documented'

  setting :test_dirs, :value => %w{ features spec }.select{|dir| File.exist? dir},
          :description => '[Array<String>] the directories that may contain test code that should not be documented'

  setting :coverage_dirs, :value => %w{ lib app controller model features spec }.select{|dir| File.exist? dir},
          :description => '[Array<String>] the directories used for code coverage metrics (usually source_dirs + test_dirs)'

  setting :yard_output_dir, :value => 'doc/ydoc',
          :description => '[String] relative path to the directory to write yard documentation to'

  setting :rdoc_output_dir, :value => 'doc/rdoc',
          :description => '[String] relative path to the directory to write rdoc documentation to'

  setting :doc_dir, :value => 'doc',
          :description => '[String] relative path to the document directory'

  setting :coverage_output_dir, :value => 'doc/coverage',
          :description => '[String] relative path to the directory to write coverage info to'

  setting :db_dir, :value => 'db',
          :description => '[String] relative path to the directory where your database lives'

  setting :db_config_file, :value => 'db/config.rb',
          :description => '[String] relative path to the database config file'

  setting :db_migration_dir, :value => 'db/migrations',
          :description => '[String] relative path to the directory where the database migration files belong'

  SettingsHelp = <<-END_SETTINGS_HELP
The Settings hash is shared among the rake tasks and key/value pairs may be overridden in the Rakefile.
For example, override the application name from the Rakefile:

  Settings[:app_name] = 'my glorious application'

Keys => values are:
#{SettingDescriptions.map{|key, value| "  #{sprintf("%20s", ':' + key.to_s)} => #{value}"}.join("\n")}
  END_SETTINGS_HELP
end

unless defined? Settings

  # The Settings hash shared among the rake tasks.  Keys are:
  #
  #   * :app_name => [String] the application name
  #   * :source_dirs => [Array<String>] the directories that may contain source files to be documented
  #   * :test_dirs => [Array<String>] the directories that may contain test code that should not be documented
  #   * :coverage_dirs => [Array<String>] the directories used for code coverage metrics (usually source_dirs + test_dirs)
  #   * :yard_output_dir => [String] relative path to the directory to write yard documentation to
  #   * :rdoc_output_dir => [String] relative path to the directory to write rdoc documentation to
  #   * :doc_dir => [String] relative path to the document directory
  #   * :coverage_output_dir => [String] relative path to the directory to write coverage info to
  #   * :db_dir => [String] relative path to the directory where your database lives
  #   * :db_config_file => [String] relative path to the database config file
  #   * :db_migration_dir => [String] relative path to the directory where the database migration files belong
  Settings = {
      :app_name => 'Application Name',
      :source_dirs => %w{ lib app controller model }.select{|dir| File.exist? dir},
      :test_dirs => %w{ features spec }.select{|dir| File.exist? dir},
      :coverage_dirs => %w{ lib app controller model features spec }.select{|dir| File.exist? dir},
      :yard_output_dir => 'doc/ydoc',
      :rdoc_output_dir => 'doc/rdoc',
      :doc_dir => 'doc',
      :coverage_output_dir => 'doc/coverage',
      :db_dir => 'db',
      :db_config_file => 'db/config.rb',
      :db_migration_dir => 'db/migrations'
  }
end

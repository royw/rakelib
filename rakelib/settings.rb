unless defined? Settings
  Settings = {
      :app_name => 'Application Name',
      :source_dirs => %w{ lib app controller model },
      :test_dirs => %w{ spec },
      :code_dirs => %w{ lib app controller model spec },
      :yard_output_dir => 'ydoc',
      :rdoc_output_dir => 'rdoc',
      :coverage_output_dir => 'coverage',
      :db_dir => 'db',
      :db_config_file => 'db/config.rb',
      :db_migration_dir => 'db/migrations'
  }
end

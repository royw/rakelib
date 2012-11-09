# This rakefile should automatically include all the tasks in the rakelib

# define our project's environment by overriding the Settings defaults
require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)

Settings[:app_name]             = 'Example App'
Settings[:source_dirs]          = %w{ lib rakelib }

# Note that all of our rake tasks are defined in .rake files in rakelib/

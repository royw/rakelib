# This rakefile should automatically include all the tasks in the rakelib

# define our project's environment by overriding the Settings defaults
require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)
Settings[:app_name]             = 'Example App'
Settings[:yard_output_dir]      = 'doc/ydoc'
Settings[:rdoc_output_dir]      = 'doc/rdoc'
Settings[:coverage_output_dir]  = 'doc/coverage'
Settings[:source_dirs]          = %w{ lib }
Settings[:coverage_dirs]        = %w{ lib spec }

# Note that all of our rake tasks are defined in .rake files in rakelib/

# rakelib

This is a smorgasbord collection of rake tasks that can easily be added to a project.

## Usage

* In your project, create a rakelib directory.
* Copy the rakelib/*.rake file(s) you want from here.
* Customize the .rake file(s) for your project.
* Initialize the Settings hash in your Rakefile.

## Globals

The following settings may be assigned values in your Rakefile.

``` ruby
    Settings = {
        :app_name => 'Example App',
        :source_dirs => %w{ lib app controller model },
        :test_dirs => %w{ spec },
        :code_dirs => %w{ lib app controller model spec },
        :yard_output_dir => 'doc/app',
        :rdoc_output_dir => 'doc/rdoc',
        :coverage_output_dir => 'doc/coverage'
    }
```

where:

    :app_name => [String] the application name
    :source_dirs => [Array<String>] an array of directory paths that contain source code.
    :test_dirs => [Array<String>] an array of directory paths that contain test code.
    :code_dirs => [Array<String>] an array of directory paths that contain source or test code.
    :yard_output_dir => [String] the directory where yard documentation will be placed.
    :rdoc_output_dir => [String] the directory where rdoc documentation will be placed.
    :coverage_output_dir => [String] the directory where coverage reports and cache will be placed.

    Note: all paths are relative to the project's root directory.

## Examples

This repository is also an example of how to use the rakelib tasks.
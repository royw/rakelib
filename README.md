# rakelib

This is a smorgasbord collection of rake tasks that can easily be added to a project.

## Usage

* In your project, create a rakelib directory.
* Copy the rakelib/*.rake file(s) you want from here.
* Customize the .rake file(s) for your project.

## Globals

The following constants should be assigned values in your Rakefile.

    APP_NAME = String defaults to ''
    SOURCE_DIRS = Array of String paths defaults to ['lib', 'app', 'controller', 'model']
    TEST_DIRS = Array of String paths defaults to ['spec']
    CODE_DIRS = Array of String paths defaults to (SOURCE_DIRS + TEST_DIRS).uniq

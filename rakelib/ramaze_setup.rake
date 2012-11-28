require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)

# Ramaze http://ramaze.net/
# Ramaze web framework
#
# rake init:ramaze  # Sets up ramaze to be part of your gem
#
#
# Uses these settings:
# * Settings[:ramaze_app_dir]
# * Settings[:ramaze_model_dir]
# * Settings[:ramaze_controller_dir]
# * Settings[:ramaze_view_dir]
# * Settings[:ramaze_public_dir]
# * Settings[:ramaze_layout_dir]
# * Settings[:ramaze_spec_dir]
#
# add to your .gemspec:
#   gem.add_development_dependency('rake')
#   gem.add_development_dependency('ramaze')
#   gem.add_development_dependency('rack-accept')
#   gem.add_development_dependency('rack-test')
#   gem.add_development_dependency('haml')
#   gem.add_development_dependency('sass')
# or add to your Gemfile:
#   gem 'rake'
#   gem 'ramaze'
#   gem 'rack-accept'
#   gem 'rack-test', require: 'rack/test'
#   gem 'haml'
#   gem 'sass'


Settings.setting :ramaze_app_dir, :value => "lib/#{Settings[:app_dir]}",
                 :description => 'The directory that contains the app.rb file.'

Settings.setting :ramaze_model_dir, :value => "#{Settings[:ramaze_app_dir]}/model",
                 :description => 'The directory where the models are.'

Settings.setting :ramaze_controller_dir, :value => "#{Settings[:ramaze_app_dir]}/controller",
                 :description => 'The directory where the controllers are.'

Settings.setting :ramaze_view_dir, :value => "#{Settings[:ramaze_app_dir]}/view",
                 :description => 'The directory where the views are.'

Settings.setting :ramaze_public_dir, :value => "#{Settings[:ramaze_app_dir]}/public",
                 :description => 'The directory where the public files go.'

Settings.setting :ramaze_layout_dir, :value => "#{Settings[:ramaze_app_dir]}/layout",
                 :description => 'The directory where the layout helpers are.'

Settings.setting :ramaze_spec_dir, :value => "#{Settings[:ramaze_app_dir]}/spec",
                 :description => 'The directory where the specs are.'

require File.expand_path('rakelib/ramaze_setup.rb', Rake.application.original_dir)

namespace :init do
  desc 'Initialize ramaze'
  task :ramaze do
    RamazeSetup::create
    RamazeSetup::create_bin
  end
end


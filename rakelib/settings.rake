require 'pp'
require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)

namespace :settings do
  desc "Show the project's settings"
  task :show do
    puts Settings.setting_values.map{ |key, value| "  #{sprintf("%20s", ':' + key.to_s)} => #{value}" }.join("\n")
  end

  desc 'Display info about the Settings hash'
  task :help do
    puts Settings.help
  end
end
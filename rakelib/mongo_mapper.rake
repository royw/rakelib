# Adds support for mongo_mapper (http://mongomapper.com), a ruby ORM for mongodb
#
# Make sure to install a mongodb somewhere.
# mac:
#   brew install mongodb
#
# add to your .gemspec:
#   gem.add_dependency('mongo')
#   gem.add_dependency('mongo_mapper', "~> 0.12.0")
#   gem.add_dependency('bson_ext')
#   gem.add_dependency('bcrypt-ruby')

begin

  require 'mongo_mapper'
  require 'database_cleaner'

  namespace :mongodb do
    desc 'run mongodb'
    task :start do
      puts `launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist`
    end

    desc 'stop mongodb'
    task :stop do
      puts `launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist`
    end

    desc 'reset database'
    task :reset do
      MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => ::Logger.new($stdout))
      MongoMapper.database = "gung_ho-dev}"
      DatabaseCleaner[:mongo_mapper].strategy = :truncation
      DatabaseCleaner.clean
    end
  end

rescue LoadError => ex
  puts "Can not load mongo_mapper tasks.  #{ex.to_s}"
end

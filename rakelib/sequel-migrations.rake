# add to your .gemspec:
#   gem.add_development_dependency('sequel')

begin
  require_relative 'db/config'
  namespace 'db' do
    desc "Run database migrations where mode is: #{Database::DB_MODES.join(', ')}"
    task :migrate, :mode do |t, args|
      cmd = "sequel -m db/migrations #{Database.url(mode(args[:mode]))}"
      puts cmd
      puts `#{cmd}`
    end

    desc 'Zap the database my running all the down migrations'
    task :zap, [:mode] do |t, args|
      cmd = "sequel -m db/migrations -M 0 #{Database.url(mode(args[:mode]))}"
      puts cmd
      puts `#{cmd}`
    end

    desc 'Reset the database then run the migrations'
    task :reset, [:mode] => [:zap, :migrate]
  end
rescue LoadError
  warn "db/config not available, sequel migration tasks not provided."
end

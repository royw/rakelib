# add to your .gemspec:
#   gem.add_development_dependency('versionomy')

begin
  require 'versionomy'
  namespace :version do
    namespace :bump do
      desc 'bump the patch version'
      task :patch do
        Dir['**/version.rb'].each do |version_file|
          str = IO.read(version_file)
          if str =~ /\"(\d+\.\d+\.\d+)\"/m
            version = Versionomy.parse $1
            new_version = version.bump(:tiny)
            File.open(version_file, 'w') {|f| f.puts str.gsub(version.to_s, new_version.to_s)}
            puts "updated version from #{version.to_s} to #{new_version}"
          end
        end
      end
    end
  end
rescue LoadError
  warn "versionomy not available, version bump tasks not provided."
end

require 'fileutils'
require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)
require File.expand_path('rakelib/gem_file.rb', Rake.application.original_dir)
require File.expand_path('rakelib/gemspec_file.rb', Rake.application.original_dir)

@gemspec = Dir["#{Rake.application.original_dir}/*.gemspec"].first

namespace :update do
  desc 'Update the Gemfile with dependencies from rakelib/*.rake files'
  task :gemfile do
    needed_gems = []
    Dir["#{Rake.application.original_dir}/rakelib/*.rake"].each do |fn|
      IO.readlines(fn).each do |line|
        if line =~ %r{^#\s+gem\s+['"]([^'"]+)['"]([^#]+)}
          needed_gems << "gem '#{$1}'#{$2}"
        end
      end
    end
    gem_file = GemFile.new
    gem_file.load "#{Rake.application.original_dir}/Gemfile"
    gem_file.dev_gems = needed_gems.uniq.sort
    gem_file.save
  end

  unless @gemspec.nil?
    desc "Update the #{@gemspec} file with dependencies from rakelib/*.rake files"
    task :gemspecfile do
      needed_gems = []
      Dir["#{Rake.application.original_dir}/rakelib/*.rake"].each do |fn|
        IO.readlines(fn).each do |line|
          #   gem.add_development_dependency('cane')
          if line =~ %r{^\s*#\s*gem\.add_development_dependency\s*\(?\s*['"]([^'"]+)['"]\s*\)?([^#]+)}
            needed_gems << "gem.add_development_dependency('#{$1}')#{$2}"
          end
        end
      end
      gemspec_file = GemspecFile.new
      gemspec_file.load(@gemspec)
      gemspec_file.dev_gems = needed_gems.uniq.sort
      gemspec_file.save
    end
  end
end

namespace :init do
  desc 'replace Gemfile with Gemfile.init'
  task :gemfile do
    initial_gem_file = File.expand_path('Gemfile.init', Rake.application.original_dir)
    if File.exist? initial_gem_file
      gem_file = File.expand_path('Gemfile', Rake.application.original_dir)
      File.delete gem_file if File.exist? gem_file
      FileUtils.cp initial_gem_file, gem_file
    end
  end

  desc "replace #{File.basename(@gemspec)} with #{File.basename(@gemspec)}.init"
  task :gemspecfile do
    initial_gem_file = File.expand_path(File.basename(@gemspec) + '.init', Rake.application.original_dir)
    if File.exist? initial_gem_file
      gem_file = File.expand_path(File.basename(@gemspec), Rake.application.original_dir)
      File.delete gem_file if File.exist? gem_file
      FileUtils.cp initial_gem_file, gem_file
    end
  end
end

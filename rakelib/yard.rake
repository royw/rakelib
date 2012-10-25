
# add to your .gemspec:
#   gem.add_development_dependency('yard')
#
# if you want syntax highlighting via pygments (http://pygments.org)
# * install pygments
# * add the following to your .gemspec
#   gem.add_development_dependency('yard-pygmentsrb')
#   gem.add_development_dependency('pygments.rb')
#
# then your markdown can include code fragments like:
# ``` ruby
#   puts 'Howdy!'
# ```

begin
  require 'yard'
  require 'erb'

  desc 'remove the generated documentation'
  task :clean do
    puts "removing old documentation"
    FileUtils.rm_rf File.expand_path('doc', File.dirname(__FILE__))
    FileUtils.rm_rf File.expand_path('rdoc', File.dirname(__FILE__))
    FileUtils.rm_rf File.expand_path('.yardoc', File.dirname(__FILE__))
  end

  desc 'convert .md.erb documentation to .md'
  task :markdown_erb do
    Dir['**/*.md.erb'].each do |fn|
      output_file = File.expand_path(fn.gsub(/\.md\.erb$/, '.md'), File.dirname(__FILE__))
      puts "processing: #{fn} to #{output_file}"
      template = ERB.new IO.read(fn)
      File.open(output_file, 'w') {|f| f.puts template.result(binding)}
    end
  end

  YARD::Rake::YardocTask.new do |t|
    t.files = ['lib/**/*.rb']
    t.options = ['--output-dir', 'doc/app/', '--markup', 'markdown', '--readme', 'README.md']
  end

  desc 'generate documentation'
  task :doc => [:markdown_erb, :yard]
rescue LoadError
  warn "yard or erb not available, yard documentation tasks not provided."
end

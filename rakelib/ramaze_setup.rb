require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)

require 'tempfile'

module RamazeSetup
  def self.create
    app_dir = File.expand_path(Settings[:ramaze_app_dir], Rake.application.original_dir)
    parent_dir = File.dirname app_dir
    app_dir_name = File.basename app_dir
    Dir.chdir(parent_dir) do
      temp_file = Tempfile.new(app_dir_name)
      temp_dirname = temp_file.path
      temp_file.close(true)
      FileUtils.cp_r app_dir_name, temp_dirname
      puts `ramaze create -f #{app_dir_name}`
      FileUtils.cp_r Dir["#{temp_dirname}/**/*"], app_dir_name
      FileUtils.rm_rf temp_dirname
    end
  end

  def self.create_bin
    FileUtils.mkdir_p Settings[:bin_dir]
    filename = File.expand_path(Settings[:app_dir], Settings[:bin_dir])
    File.open(filename, 'w') do |f|
      f.puts <<-END_SCRIPT
#!/usr/bin/env ruby

require File.expand_path("../#{Settings[:ramaze_app_dir]}/app", File.dirname(__FILE__))

Ramaze.start(:adapter => :webrick, :port => 7000, :file => File.expand_path("../#{Settings[:ramaze_app_dir]}/start.rb", File.dirname(__FILE__)))

END_SCRIPT
    end
    File.chmod(0755, filename)
  end

end

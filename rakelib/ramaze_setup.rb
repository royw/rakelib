require File.expand_path('rakelib/settings.rb', Rake.application.original_dir)


module RamazeSetup
  def self.create
    app_dir = File.expand_path(Settings[:ramaze_app_dir], Rake.application.original_dir)
    parent_dir = File.dirname app_dir
    app_dir_name = File.basename app_dir
    Dir.chdir(parent_dir) do
      `ramaze create -f #{app_dir_name}`
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

# database config settings

require 'sequel'
require 'fileutils'

module Database
  DB_MODES = %w{dev live test}
  DB_DIR = File.expand_path('data', File.dirname(__FILE__))
  FileUtils.mkdir_p DB_DIR
  def self.url(mode)
    raise "Unsupported runtime mode (Ramaze.options.mode): #{mode.inspect}" unless DB_MODES.include? mode.to_s
    "sqlite://#{DB_DIR}/bar-tender-#{mode.to_s}.db"
  end
end

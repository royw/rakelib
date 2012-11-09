unless Kernel.respond_to?(:require_relative)
  module Kernel
    # TODO need documentation
    def require_relative(path)
      filename = path.to_str
      filename += '.rb' unless filename =~ /\.rb$/
      require File.join(File.dirname(caller[0]), filename)
    end
    def load_relative(path)
      filename = path.to_str
      filename += '.rb' unless filename =~ /\.rb$/
      load File.join(File.dirname(caller[0]), filename)
    end
  end
end

require_relative 'example/version'

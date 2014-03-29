require 'dependor'
require 'dependor/shorty'
require 'wiringpi'
module RaspberryPi; end
module Connections; end
module SkiraceWorker; end

Dir[File.expand_path('../skirace_worker/**/*.rb', __FILE__)].each do |file|
  require file
end

module SkiraceWorker 
  class Runner
    def self.run
      injector.worker.run
    end

    def self.injector(opts = {})
      Injector.new(opts)
    end
  end
end

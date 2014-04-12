require 'dependor'
require 'dependor/shorty'
require 'wiringpi'
require 'ostruct'
require 'pry'

module Components; end
module RaspberryPi; end
module Connections; end
module SkiraceWorker
  class << self
    def env
      ENV['WORKER_ENV'] ||= 'development'
    end
  end
end

Dir[File.expand_path('../skirace_worker/**/*.rb', __FILE__)].each do |file|
  require file
end
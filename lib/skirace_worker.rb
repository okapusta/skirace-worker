require 'dependor'
require 'dependor/shorty'
require 'wiringpi'
require 'ostruct'
require 'dalli'
require 'pry'

module Components; end
module RaspberryPi; end
module Connections; end
module SkiraceWorker
  file = File.join('.', 'tmp', 'skirace-worker.pid')
  File.open(file, 'w') { |file| file.write(Process.pid) } if File.file?(file)

  class << self
    def env
      ENV['WORKER_ENV'] ||= 'development'
    end
  end
end

Dir[File.expand_path('../skirace_worker/**/*.rb', __FILE__)].each do |file|
  require file
end
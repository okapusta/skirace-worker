require 'dependor'
require 'dependor/shorty'
require 'wiringpi'

module SkiraceWorker; end
module RaspberryPi; end
module Connections; end

Dir[File.expand_path('../skirace_worker/**/*.rb', __FILE__)].each do |file|
  require file
end
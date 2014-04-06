require 'dependor'
require 'dependor/shorty'
require 'wiringpi'

module Components; end
module RaspberryPi; end
module Connections; end
module SkiraceWorker; end

Dir[File.expand_path('../skirace_worker/**/*.rb', __FILE__)].each do |file|
  require file
end
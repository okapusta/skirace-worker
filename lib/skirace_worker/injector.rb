require 'a9n'
require 'json'
require 'rest-client'

class Injector
  include Dependor::AutoInject

  look_in_modules Connections, RaspberryPi, Components

  def initialize(opts = {})
    io.wiringPiSetup
  end

  def http_client
  	RestClient
  end

  def io
    Wiringpi
  end

  def time_sleep
    1.0000000/1000000
  end

  def time
    Time
  end 

  def json_parser
    JSON
  end

end

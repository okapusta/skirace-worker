class Injector
  include Dependor::AutoInject

  look_in_modules Connections, RaspberryPi, Components

  def initialize(opts = {})
  end

  def http_client
  	RestClient
  end

  def io
    WiringPi::GPIO.new
  end

end

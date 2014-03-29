class Injector
  include Dependor::AutoInject

  look_in_modules Connections, RaspberryPi

  def initialize(opts = {})
  end

  def io
    WiringPi::GPIO.new
  end

end
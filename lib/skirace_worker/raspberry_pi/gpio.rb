class RaspberryPi::Gpio
  takes :io

  def read(pin)
    io.read(pin)
  end
  
  def write(pin, value)
    io.write(pin, value)
  end

  def mode(pin, mode)
    io.mode(pin, mode)
  end
end
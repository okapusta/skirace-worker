class RaspberryPi::Gpio
  takes :io

  def write(pin, value)
    io.write(pin, value)
  end

  def read(pin)
    io.read(pin)
  end
end
class RaspberryPi::Gpio
  takes :io

  def read(pin)
    io.mode(pin, INPUT)
    io.read(pin)
  end
  
  def write(pin, value)
    io.mode(pin, OUTPUT)
    io.write(pin, value)
  end
 
  private

    def mode(pin, mode)
      io.mode(pin, mode)
    end
end

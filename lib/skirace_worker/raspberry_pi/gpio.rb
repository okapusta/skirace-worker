class RaspberryPi::Gpio
  takes :io

  def read(pin)
    mode(pin, INPUT)
    io.digitalRead(pin)
  end
  
  def write(pin, value)
    mode(pin, OUTPUT)
    io.digitalWrite(pin, value)
  end
 
  private

    def mode(pin, mode)
      io.pinMode(pin, mode)
    end
end

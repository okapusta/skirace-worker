class Components::Capacitor
  takes :gpio
  
  def discharge(pin)
    gpio.mode(pin, OUTPUT)
    gpio.write(pin, LOW)
  end
end
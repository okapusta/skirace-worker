class Components::Capacitor
  takes :gpio
  
  def discharge(pin)
    gpio.write(pin, LOW)
  end
end

class Worker
  takes :gpio
  takes :options

  def run
    while true
      # p "Discharging capacitor"
      # discharge_capacitor(options.gpio_pin)
      
      gpio.write(options.gpio_pin, LOW)
      sleep 0.1
      reading = 0
      while gpio.read(options.gpio_pin) == LOW
        reading += 1
      end
      puts reading
    end
  end

  def discharge_capacitor(pin)
    
  end
end
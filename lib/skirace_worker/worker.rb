class Worker
  takes :gpio, :options

  def run
    while true
      discharge_capacitor(options.gpio_pin)      
      sleep 0.1; reading = 0;

      gpio.mode(options.gpio_pin, INPUT)
      while gpio.read(options.gpio_pin) == LOW
        reading += 1
      end
      puts reading
    end
  end

  def discharge_capacitor(pin)
    gpio.mode(options.gpio_pin, OUTPUT)
    gpio.write(options.gpio_pin, LOW)
  end
end
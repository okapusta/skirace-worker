class Worker
  takes :gpio, :options, :capacitor

  def run
    while true
      capacitor.discharge(options.gpio_pin)      
      sleep 0.1; reading = 0;

      gpio.mode(options.gpio_pin, INPUT)
      while gpio.read(options.gpio_pin) == LOW
        reading += 1
      end
      puts reading
    end
  end
end
class Worker
  takes :gpio, :options, :capacitor, :lcd_screen, :memcache, :formatter, :time

  def work
    lcd_screen.init

    while result = get_measurement
      if result < options.activation_threshold
        start_time = memcache.get("start_time")
        end_time   = start_time - time.now

        lcd_screen.write(formatter.time_format(end_time))
      end
    end
  end

  private

    def get_measurement
      capacitor.discharge(options.capacitor.pin)      
      sleep 0.01; reading = 0;

      while gpio.read(options.capacitor.pin) == LOW
        reading += 1
      end
      reading
    end
end

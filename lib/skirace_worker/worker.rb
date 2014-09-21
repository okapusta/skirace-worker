class Worker
  takes :gpio, :options, :capacitor, :lcd_screen, :memcache, :formatter, :time, :application

  def work
    lcd_screen.init

    while result = get_measurement
      if result > options.activation_threshold
        # start_time = memcache.get("start_time")
        response = application.end_time(time.now)
        if response #start_time && end_time = (time.now-start_time)
          lcd_screen.write(formatter.time_format(response))
        end
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

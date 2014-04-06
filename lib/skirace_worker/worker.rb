class Worker
  takes :gpio, :options, :capacitor

  def work
    while true
      capacitor.discharge(options.capacitor.pin)      
      sleep 0.01; reading = 0;

      while gpio.read(options.capacitor.pin) == LOW
        reading += 1
      end
      puts reading
    end
  end
end

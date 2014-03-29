class Worker
  takes :gpio

  def run
    while true
      puts gpio.read(18)
      sleep 0.1
    end
  end
end
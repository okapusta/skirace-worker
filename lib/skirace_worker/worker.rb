class Worker
  takes :gpio

  def run
    while true
      puts gpio.read(4)
      sleep 0.1
    end
  end
end
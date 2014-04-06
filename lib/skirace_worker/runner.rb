class SkiraceWorker::Runner
	class << self
    def run
      injector.worker.work
    end

    def injector(opts = {})
      Injector.new(opts)
    end
  end
end

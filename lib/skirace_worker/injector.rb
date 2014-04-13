require 'a9n'

class Injector
  include Dependor::AutoInject

  look_in_modules Connections, RaspberryPi, Components

  def initialize(opts = {})
    load_config
    
    io.wiringPiSetup
  end

  def http_client
  	RestClient
  end

  def config
    A9n
  end

  def io
    WiringPi
  end

  private

    def load_config
      A9n.root = File.expand_path('../../..', __FILE__)
      A9n.local_app = SkiraceWorker

      A9n.load
    end

end

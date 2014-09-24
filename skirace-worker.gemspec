Gem::Specification.new do |s|
  s.name    = 'skirace-worker'
  s.version = '0.0.1'
  s.summary = 'SkiRace App finish line worker'
  s.description = 'registers crossing of finishline'
  s.authors = ["Oskar Kapusta"]
  s.email   = ["oskar,kapusta@kapuh.com"]
  s.files   = [ 'bin/skirace-worker',
    'lib/skirace_worker.rb',
    'lib/skirace_worker/injector.rb',
    'lib/skirace_worker/worker.rb',
    'lib/skirace_worker/options.rb',
    'lib/skirace_worker/raspberry_pi/gpio.rb'
  ]
  s.executables << 'skirace-worker'
  s.homepage = "http://kapuh.com"
  s.license = "MIT"

  s.add_dependency "dalli"
  s.add_dependency "dependor"
  s.add_dependency "wiringpi"
  s.add_dependency "rest-client"
  s.add_dependency "god"
  s.add_dependency "pry"
  s.add_development_dependency "capistrano"
end

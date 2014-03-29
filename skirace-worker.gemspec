Gem::Specification.new do |s|
  s.name    = 'skirace-worker'
  s.version = '0.0.1'
  s.summary = 'SkiRace App finish line worker'
  s.description = 'registers crossing of finishline'
  s.authors = ["Oskar Kapusta"]
  s.email   = ["oskar,kapusta@kapuh.com"]
  s.files   = Dir[File.expand_path('../lib/skirace_worker/**/*.rb', __FILE__)]
  s.homepage = "http://kapuh.com"
  s.license = "MIT"
end

require File.expand_path('../lib/lxc/server/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "lxc-server"
  s.version     = LXC::SERVER_VERSION
  s.summary     = "API server for LXC"
  s.description = "Sinatra-based API for LXC container management"
  s.homepage    = "https://github.com/sosedoff/lxc-server"
  s.authors     = ["Dan Sosedoff"]
  s.email       = ["dan.sosedoff@gmail.com"]
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec',     '~> 2.11'
  s.add_development_dependency 'simplecov', '~> 0.4'

  s.add_runtime_dependency 'lxc-ruby',   '~> 0.2'
  s.add_runtime_dependency 'sinatra',    '~> 1.3'
  s.add_runtime_dependency 'multi_json', '~> 1.3'
  s.add_runtime_dependency 'thin',       '~> 1.3'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  s.require_paths = ["lib"]
end
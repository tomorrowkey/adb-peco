# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'adb/peco/version'

Gem::Specification.new do |spec|
  spec.name          = 'adb-peco'
  spec.version       = Adb::Peco::VERSION
  spec.authors       = ['Tomoki Yamashita']
  spec.email         = ['tomorrowkey@gmail.com']

  spec.summary       = %q{Run adb command with peco}
  spec.description   = %q{Run adb command with peco}
  spec.homepage      = 'http://github.com/tomorrowkey/adb-peco'
  spec.license       = 'Apache License 2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'device_api-android', '~> 1.2'
  spec.add_dependency 'peco_selector', '~> 1.0'
  spec.add_development_dependency 'bundler', '>= 2.2.33'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
end

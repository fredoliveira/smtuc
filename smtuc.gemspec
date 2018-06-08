lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smtuc/version'

Gem::Specification.new do |s|
  s.name          = 'smtuc'
  s.version       = SMTUC::VERSION
  s.date          = '2018-06-08'

  s.summary       = 'SMTUC, the gem!'
  s.description   = 'A non-official gem on top of a non-fficial API to SMTUC'
  s.authors       = ['Fred Oliveira']
  s.email         = 'fred@helloform.com'
  s.license       = 'MIT'
  s.homepage      = 'https://github.com/fredoliveira/smtuc-gem'

  s.files         = ['lib/smtuc.rb', 'lib/smtuc/line.rb', 'lib/smtuc/stop.rb']
  s.require_paths = ['lib']

  s.add_runtime_dependency 'faraday', '~> 0.11.0'

  s.add_development_dependency 'bundler', '~> 1.16'
  s.add_development_dependency 'minitest', '~> 5.0'
  s.add_development_dependency 'rake', '~> 10.0'
end

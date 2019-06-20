lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'invalid_json_error_middleware/version'

Gem::Specification.new do |s|
  s.name        = 'invalid_json_error_middleware'
  s.version     = InvalidJsonErrorMiddleware::VERSION
  s.summary     = 'Invalid Json Error Middleware'
  s.description = 'Rails rack middleware to catch JSON parse errors'
  s.authors     = ['Ihor Voloshyn']
  s.email       = 'ivoloshy@cisco.com'
  s.files       = Dir['lib/invalid_json_error_middleware.rb', 'lib/invalid_json_error_middleware/*.rb', 'spec/*.rb']
  s.extra_rdoc_files = %w[README.md]
  s.homepage    = 'https://github.com/Cisco-AMP/invalid_json_error_middleware'
  s.license     = 'MIT'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rack-test'
  s.add_dependency 'json'
end

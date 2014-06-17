# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quiet_routes/version'

Gem::Specification.new do |spec|
  spec.name          = "quiet_routes"
  spec.version       = QuietRoutes::VERSION
  spec.authors       = ["Yusuke Tanaka"]
  spec.email         = ["y.tanaka@aktsk.jp"]
  spec.summary       = %q{Turns off Rails particular log.}
  spec.description   = %q{Quiet Assets turns off Rails particular log.}
  spec.homepage      = "https://github.com/yusuket/quiet_routes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end

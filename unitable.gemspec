# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unitable/version'

Gem::Specification.new do |spec|
  spec.name          = "unitable"
  spec.version       = Unitable::VERSION
  spec.authors       = ["Kip Cole"]
  spec.email         = ["kipcole9@gmail.com"]
  spec.summary       = %q{Unit conversion gem}
  spec.description   = %q{Unit conversion gem.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "i18n"
  spec.add_dependency "twitter_cldr"
  spec.add_dependency "activesupport"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

end

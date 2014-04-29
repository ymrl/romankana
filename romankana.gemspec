lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'romankana/version'

Gem::Specification.new do |spec|
  spec.name          = "romankana"
  spec.version       = RomanKana::VERSION
  spec.authors       = ["ymrl"]
  spec.email         = ["ymrl@ymrl.net"]
  spec.summary       = %q{Roman Alphabet <-> Japanese Hiragana/Katkakana Convert Library for Ruby}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/ymrl/romankana"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 1.9"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end

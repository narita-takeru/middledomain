# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "middledomain/version"

Gem::Specification.new do |spec|
  spec.name          = "middledomain"
  spec.version       = MiddleDomain::VERSION
  spec.authors       = ["narita_takeru"]
  spec.email         = ["naritano77@gmail.com"]

  spec.summary       = %q{Common logic for domain layer.}
  spec.description   = %q{Common logic for domain layer.}
  spec.homepage      = "https://github.com/narita-takeru"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "rails", "~> 5.1"
  spec.add_dependency "activerecord", "~> 5.1"
end

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hubspot/version"

Gem::Specification.new do |spec|
  spec.name          = "hubspot-api"
  spec.version       = Hubspot::VERSION
  spec.authors       = ["Dinko Azema"]
  spec.email         = [""]

  spec.summary       = %q{This gem is a custom version to connect with hubspot}
  spec.description   = %q{This gem is a custom version to connect with hubspot}
  spec.homepage      = "https://github.com/poliglota-ti/hubspot-api"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  # dependencies
  spec.add_dependency "httparty", ">= 0.16.4"
end

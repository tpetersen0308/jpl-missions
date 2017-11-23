
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jpl_missions/version"

Gem::Specification.new do |spec|
  spec.name          = "jpl_missions"
  spec.version       = JPLMissions::VERSION
  spec.authors       = ["'Travis Petersen'"]
  spec.email         = ["'travis.e.petersen@gmail.com'"]

  spec.summary       = %q{NASA JPL Missions}
  spec.description   = %q{This Ruby Gem provides a command line interface to browse current, past, and future
  missions of NASA's Jet Propulsion Laboratory in Pasadena, CA.}
  spec.homepage      = "https://github.com/tpetersen0308/jpl-missions"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end

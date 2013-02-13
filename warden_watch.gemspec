# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'warden_watch/version'

Gem::Specification.new do |gem|
  gem.name          = 'warden_watch'
  gem.version       = WardenWatch::VERSION
  gem.authors       = ["Dan Pickett", 'Jason Zopf']
  gem.email         = ['dan.pickett@launchware.com']
  gem.description   = %q{tracks user logins with warden}
  gem.summary       = %q{tracks user logins with warden}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'fuubar'
  gem.add_development_dependency 'guard-rspec'
end


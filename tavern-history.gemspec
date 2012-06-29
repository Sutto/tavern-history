# -*- encoding: utf-8 -*-
require File.expand_path('../lib/tavern/history/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Darcy Laycock"]
  gem.email         = ["sutto@sutto.net"]
  gem.description   = %q{Adds support for history to tavern.}
  gem.summary       = %q{Adds support for history to tavern.}

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "tavern-history"
  gem.require_paths = ["lib"]
  gem.version       = Tavern::History::VERSION

  gem.add_dependency 'multi_json'
  gem.add_dependency 'redis'
  gem.add_dependency 'tavern'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'

end

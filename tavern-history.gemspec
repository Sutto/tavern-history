# -*- encoding: utf-8 -*-
require File.expand_path('../lib/tavern/history/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Darcy Laycock"]
  gem.email         = ["sutto@sutto.net"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "tavern-history"
  gem.require_paths = ["lib"]
  gem.version       = Tavern::History::VERSION

  gem.add_dependency 'multi_json'
  gem.add_dependency 'redis'
  gem.add_dependency 'tavern'

end

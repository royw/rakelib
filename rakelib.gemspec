# -*- encoding: utf-8 -*-
require File.expand_path('../lib/example/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Roy Wright"]
  gem.email         = ["roy@wright.org"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "Example"
  gem.require_paths = ["lib"]
  gem.version       = Example::VERSION
  gem.add_development_dependency('bcrypt-ruby')
  gem.add_development_dependency('bson_ext')
  gem.add_development_dependency('cane')
  gem.add_development_dependency('capybara')
  gem.add_development_dependency('cucumber')
  gem.add_development_dependency('cucumber-api-steps')
  gem.add_development_dependency('curb')
  gem.add_development_dependency('database_cleaner')
  gem.add_development_dependency('doc_to_dash')
  gem.add_development_dependency('factory_girl', '~> 2.0')  if RUBY_VERSION =~ %r{^1\.8\.}
  gem.add_development_dependency('factory_girl', '~> 3.0')  if RUBY_VERSION =~ %r{^1\.9\.}
  gem.add_development_dependency('haml')
  gem.add_development_dependency('mongo')
  gem.add_development_dependency('mongo_mapper', "~> 0.12.0")
  gem.add_development_dependency('pygments.rb')
  gem.add_development_dependency('rack-accept')
  gem.add_development_dependency('rack-test')
  gem.add_development_dependency('rake')
  gem.add_development_dependency('ramaze')
  gem.add_development_dependency('rcov') if RUBY_VERSION =~ %r{^1\.8\.}
  gem.add_development_dependency('rdoc')
  gem.add_development_dependency('redcarpet')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('sass')
  gem.add_development_dependency('sequel')
  gem.add_development_dependency('simplecov')  unless RUBY_VERSION =~ %r{^1\.8\.}
  gem.add_development_dependency('simplecov-rcov')  unless RUBY_VERSION =~ %r{^1\.8\.}
  gem.add_development_dependency('versionomy')
  gem.add_development_dependency('webrat')
  gem.add_development_dependency('xpath')
  gem.add_development_dependency('yard')
  gem.add_development_dependency('yard-blame')
  gem.add_development_dependency('yard-cucumber')
  gem.add_development_dependency('yard-pygmentsrb')
  gem.add_development_dependency('yard-rspec')
end

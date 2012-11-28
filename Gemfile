source 'https://rubygems.org'

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem 'cane'
  gem 'cucumber'
  gem 'doc_to_dash'
  gem 'pygments.rb'
  gem 'rake'
  gem 'ramaze'
  gem 'rcov' if RUBY_VERSION =~ %r{^1\.8\.}
  gem 'rdoc'
  gem 'redcarpet'
  gem 'sequel'
  gem 'simplecov'  unless RUBY_VERSION =~ %r{^1\.8\.}
  gem 'simplecov-rcov'  unless RUBY_VERSION =~ %r{^1\.8\.}
  gem 'versionomy'
  gem 'webrat'
  gem 'yard'
  gem 'yard-blame'
  gem 'yard-cucumber'
  gem 'yard-pygmentsrb'
  gem 'yard-rspec'
  gem('factory_girl', '~> 2.0') if RUBY_VERSION =~ %r{^1\.8\.}
  gem('factory_girl', '~> 3.0') if RUBY_VERSION =~ %r{^1\.9\.}
  gem('capybara')
  gem('cucumber-api-steps', :require => false)
  gem('curb')
end

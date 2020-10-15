source "https://rubygems.org"

gem "activerecord", "~> 6.0.0"
gem "rails-controller-testing"
gem "rspec-rails", "~> 4.0.0"

gem 'rqrcode', '~> 0.7.0'

group :test do
  gem 'byebug'
  gem 'appraisal', '>= 2.1'
  gem 'capybara', '>= 2.1'
  gem 'coveralls', '>= 0.7'
  gem 'factory_bot', '>= 4.1'
  gem 'rake', '>= 10.0'
  gem 'rspec-its', '>= 1.0'
  gem 'webmock', '~> 3.9'
end

# Specify your gem's dependencies in groupify.gemspec
gemspec

platforms :ruby do
  gem 'sqlite3', '>= 1.3'
end

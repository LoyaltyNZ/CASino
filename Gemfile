source "https://rubygems.org"

gem "activerecord", "~> 7.0.1"
gem "rails-controller-testing"
gem "rspec-rails", "~> 4.0.0"

gem 'rqrcode', "~> 2.0"
gem 'bundler-audit'

group :test do
  gem 'byebug'
  gem 'appraisal', '>= 2.1'
  gem 'capybara', '>= 2.1'
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

source 'https://rubygems.org'

gem 'rails', '~> 3.2.11'

# auth
gem 'devise'
gem 'cancan'

# database
gem 'pg'
gem 'squeel' # AR extensions
gem 'valium' # get values without instantiating AR
gem 'postgres-copy'

# mem cache client
# gem 'dalli'

# views
gem 'haml-rails'
gem 'kramdown' # markdown
gem 'simple_form'
gem 'simple-navigation'
gem 'simple-navigation-bootstrap'
gem 'meta-tags', '1.2.4', require: 'meta_tags'
gem 'kaminari'
gem 'twitter-bootstrap-rails'
gem 'nested_form'

# media
gem "carrierwave"
# gem 'fog'
gem 'mini_magick'
# gem "jquery-fileupload-rails"

# translations
gem 'r18n-rails'
gem 'rails-i18n'

# tags
# gem 'acts-as-taggable-on'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.3.0'
end

# js runtime
gem 'therubyracer', '~> 0.12.1'
# gem 'libv8', '3.3.10.4'

# js
gem 'jquery-rails'

# validations
gem 'valid_email'

gem 'tinymce-rails'
gem 'tinymce-rails-langs'
gem 'el_finder'

# tests
group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-rails-assets'
  gem 'database_cleaner'
  gem 'rb-fsevent', '~> 0.9.1'
end
group :test, :development do
  gem 'rspec-rails'
  gem 'spork-rails'
end

group :development do
  # server
  gem 'thin'

  # (mac)
  group :darwin do
    gem 'growl' #if RUBY_PLATFORM.downcase.include?("darwin")
  end
end

gem 'awesome_print', group: %w(test development console)

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# heroku addons
group :production, :stage do
  # gem 'newrelic_rpm'
  # gem 'thin'
  # gem 'airbrake'
end

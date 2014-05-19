source 'https://rubygems.org'
#ruby '2.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.3'

# Use sqlite3 as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem "jquery-ui-rails", "~> 4.2.0"

gem 'devise-i18n-views'
gem 'devise', '3.2.2'
gem "cancan"

gem 'jquery-fileupload-rails'
gem 'carrierwave'
gem "fog", "~> 1.3.1"

gem 'slim'

gem 'ajaxful_rating', github: 'cronon/ajaxful-rating', branch: 'rails4'
#gem 'protected_attributes' #ajaxful_rating uses attr_accessible

gem 'activeadmin', github: 'gregbell/active_admin'
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
gem 'bootstrap-sass'
group :development do
  gem 'rails_layout'
  #for vitek
  #gem 'sqlite3'
end

group :production do
  gem 'rails_12factor'
end
# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'
gem 'redcarpet'
gem "markitup-rails"

# Use unicorn as the app server
#gem 'unicorn'
gem 'thin'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end

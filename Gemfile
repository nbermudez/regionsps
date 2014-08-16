source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'gravatar_image_tag', '0.1.0'

gem "rmagick"
gem "carrierwave"
gem "fog", "~> 1.3.1"

gem 'sqlite3', :group => [:development, :test]
gem 'pg', :group => [:development, :test]

group :production, :staging do
  gem 'pg'
  gem 'rails_12factor'
end

group :production do
	gem 'thin'
end
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'therubyracer'
gem "haml-rails"

gem 'will_paginate', '~> 3.0'

source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.0.20'
gem 'pg'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
end

group :production do
  # forces the domain back to crazy-pooh.fr wherever the query originates from
  gem 'rack-force_domain'
end

# views and stylesheets use haml
gem 'haml'
gem 'sass'
gem 'sendgrid'

# use paperclip for file storage over amazon S3
gem 'aws-s3', :require => 'aws/s3'
gem 'paperclip'

# send mails
gem "mail"

# Use unicorn as the web server
gem 'unicorn'

group :development do
  gem 'foreman'
end

group :production do
  gem 'rails_12factor'
end

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

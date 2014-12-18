# Run this file with:
#
#   bundle exec RAILS_ENV=production rackup -p 3000 -s thin
#
# And access:
#
#   http://localhost:3000/hello/world
#
# We are using Bundler in this example, but we could also
# have used rubygems:
#
#   require "rubygems"
#
#   gem "actionpack"
#   gem "railties"
#
#   require "rails"
#   require "rails/all"

# The following lines should come as no surprise. Except by
# ActionController::Metal, it follows the same structure of
# config/application.rb, config/environment.rb and config.ru
# existing in any Rails 3 app. Here they are simply in one
# file and without the comments.
require "rails"
require "rails/all"

class MyApp < Rails::Application
  routes.append do
    match "/hello/world" => "hello#world"
    match "/" => "hello#home"
  end

  # Enable cache classes. Production style.
  config.cache_classes = true

  # Here you could remove some middlewares, for example
  # Rack::Lock, AD::Flash and AD::BestStandardsSupport below.
  # The remaining stack is printed on rackup (for fun!).
  # Rails 4 will have config.middleware.api_only! to get
  # rid of browser related middleware.
  config.middleware.delete "Rack::Lock"
  config.middleware.delete "ActionDispatch::Flash"
  config.middleware.delete "ActionDispatch::BestStandardsSupport"

  # We need a secret token for session, cookies, etc.
  config.secret_token = "49837489qkuweoiuoqwehisuakshdjksadhaisdy78o34y138974xyqp9rmye8yrpiokeuioqwzyoiuxftoyqiuxrhm3iou1hrzmjk"
end

# This is a barebone controller. One good reference can be found here:
# http://piotrsarnacki.com/2010/12/12/lightweight-controllers-with-rails3/
class HelloController < ActionController::Metal
  include ActionController::Rendering

  def world
    render :text => "Hello world!"
  end

  def home 
    render text: "This is home"
  end

end

# Initialize the app (originally in config/environment.rb)
MyApp.initialize!

# Print the stack for fun!
puts ">> Starting Rails lightweight stack"
Rails.configuration.middleware.each do |middleware|
  puts "use #{middleware.inspect}"
end
puts "run #{Rails.application.class.name}.routes"

# Run it (originally in config.ru)
run MyApp

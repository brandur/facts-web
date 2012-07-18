require "bundler/setup"
Bundler.require

require "logger"

# so logging output appears properly
$stdout.sync = true

# libs
$: << "./lib"
require "facts"

# Sinatra app
require "./app"

Slim::Engine.set_default_options format: :html5, pretty: true

map "/assets" do
  assets = Sprockets::Environment.new do |env|
    env.append_path(settings.root + "/assets/javascripts")
    env.append_path(settings.root + "/assets/stylesheets")
    env.logger = Logger.new($stdout)
  end
  run assets
end

map "/" do
  use Rack::Instruments
  use Rack::Robots
  run Sinatra::Application
end

require "bundler/setup"
Bundler.require

# so logging output appears properly
$stdout.sync = true

# libs
$: << "./lib"
require "facts"

# Sinatra app
require "./app"

Slim::Engine.set_default_options format: :html5, pretty: true

map "/" do
  use Rack::Instruments
  run Sinatra::Application
end

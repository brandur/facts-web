require "test_helper"

require_relative "../../app"

describe "rack categories" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before do
    stub(Facts::Config).api { "https://facts-api.localhost" }
    set :views, settings.root + "/../views"
    Artifice::Excon.activate_for(Facts::Config.api, FactsApiStub.new)
  end

  after do
    Artifice::Excon.deactivate
  end

  it "gets a category" do
    get "/heroku"
    last_response.status.must_equal 200
    last_response.body.must_match %r{<title>Heroku</title>}
  end
end

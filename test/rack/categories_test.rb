require_relative "../test_helper"

require_relative "../../app"

describe "rack categories" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before do
    set :views, settings.root + "/../views"
    stub(Facts::Config).api { "https://facts-api.localhost" }
    stub_facts_service
  end

  it "gets a category" do
    get "/heroku"
    last_response.status.must_equal 200
    last_response.body.must_match %r{<title>Heroku</title>}
  end
end

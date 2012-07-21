require "json"

helpers do
  def api
    @api ||= Excon.new(Facts::Config.api, ssl_verify_peer: false,
      instrumentor: Facts::ExconInstrumentor.new(request.env["REQUEST_ID"]))
  end

  def api_call
    yield
  rescue Excon::Errors::NotAcceptable
    # result of some bad extension being requested like /favicon.ico
    raise Sinatra::NotFound
  rescue Excon::Errors::NotFound
    raise Sinatra::NotFound
  end
end

get "/" do
  redirect "/latest"
end

get "/latest" do
  response = api_call { api.get(path: "/facts/latest", expects: 200) }
  @facts = JSON.parse(response.body).map { |f| Facts::Models::Fact.new(f) }
  @title = "Latest Facts"
  slim :show_latest
end

get "/random" do
  response = api_call { api.get(path: "/facts/random", expects: 200) }
  @facts = JSON.parse(response.body).map { |f| Facts::Models::Fact.new(f) }
  @title = "Random Facts"
  slim :show_random
end

get "/:slug" do |slug|
  response = api_call { api.get(path: "/categories/#{slug}", expects: 200) }
  @category = Facts::Models::Category.new(JSON.parse(response.body))
  @title = @category.name
  slim :show_category
end

get "/:slug/:fact_id" do |slug, fact_id|
  response = api_call { api.get(path: "/facts/#{fact_id}", expects: 200) }
  @fact = Facts::Models::Fact.new(JSON.parse(response.body))
  slim :show_fact
end

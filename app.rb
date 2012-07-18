require "json"

helpers do
  def api
    @api ||= Excon.new(Facts::Config.api,
      instrumentor: Facts::ExconInstrumentor.new(request.env["REQUEST_ID"]))
  end
end

get "/facts/latest" do
  response = api.get(path: "/facts/latest", expects: 200)
  @facts = JSON.parse(response.body).map { |f| Facts::Models::Fact.new(f) }
  @title = "Latest Facts"
  slim :show_latest
end

get "/facts/random" do
  response = api.get(path: "/facts/random", expects: 200)
  @facts = JSON.parse(response.body).map { |f| Facts::Models::Fact.new(f) }
  @title = "Random Facts"
  slim :show_random
end

get "/:slug" do |slug|
  response = api.get(path: "/categories/#{slug}", expects: 200)
  @category = Facts::Models::Category.new(JSON.parse(response.body))
  @title = @category.name
  slim :show_category
end

get "/:slug/:fact_id" do |slug, fact_id|
  response = api.get(path: "/facts/#{fact_id}", expects: 200)
  @fact = Facts::Models::Fact.new(JSON.parse(response.body))
  slim :show_fact
end

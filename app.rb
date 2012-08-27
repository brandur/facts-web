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

  def parse_categories
    response = yield
    JSON.parse(response.body).map { |f| Facts::Models::Category.new(f) }
  end

  def parse_facts
    response = yield
    JSON.parse(response.body).map { |f| Facts::Models::Fact.new(f) }
  end
end

get "/" do
  @latest_facts =
    parse_facts { api_call { api.get(path: "/facts/latest", expects: 200) } }
  @random_facts =
    parse_facts { api_call { api.get(path: "/facts/random", expects: 200) } }
  @title = "Facts"
  slim :home
end

get "/latest" do
  @facts =
    parse_facts { api_call { api.get(path: "/facts/latest", expects: 200) } }
  @title = "Latest Facts"
  slim :show_latest
end

get "/random" do
  @facts =
    parse_facts { api_call { api.get(path: "/facts/random", expects: 200) } }
  @title = "Random Facts"
  slim :show_random
end

get "/search" do
  @q = params[:q]
  @categories = parse_categories do
    api_call { api.get(path: "/categories/search", expects: 200,
      query: { q: @q }) }
  end
  @facts = parse_facts do
    response = api_call { api.get(path: "/facts/search", expects: 200,
      query: { q: @q }) }
  end
  @title = "Search: #{@q}"
  slim :show_search
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
  raise Sinatra::NotFound if @fact.category.slug != slug
  @title = "##{@fact.id}"
  slim :show_fact
end

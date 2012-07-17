require "json"

helpers do
  def api
    @api ||= Excon.new(Facts::Config.api,
      instrumentor: Facts::Instrumentor.new(request.env["REQUEST_ID"]))
  end
end

get "/:slug" do |slug|
  response = api.get(path: "/categories/#{slug}", expects: 200)
  @category = JSON.parse(response.body)
  slim :show_category
end

get "/:slug/:fact_id" do |slug, fact_id|
end

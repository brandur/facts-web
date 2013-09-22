require "facts_api_stub"

$stdout.sync = $stderr.sync = true
FactsApiStub.run! port: ENV["PORT"]

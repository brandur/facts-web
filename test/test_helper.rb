# must come before bundler requires
ENV["RACK_ENV"] = "test"

require "bundler/setup"
Bundler.require(:default, :test)

require "minitest/spec"
require "minitest/autorun"
require "webmock/minitest"

require_relative "../lib/facts"

def stub_service(uri, stub, &block)
  uri = URI(uri)
  uri.user, uri.password = nil, nil
  stub = block ? Sinatra.new(stub, &block) : stub
  stub_request(:any, /^#{uri}\/.*$/).to_rack(stub)
end

def stub_facts_service(&block)
  stub_service(Facts::Config.api, FactsApiStub, &block)
end

class MiniTest::Spec
  include RR::Adapters::TestUnit
end

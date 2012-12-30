# must come before bundler requires
ENV["RACK_ENV"] = "test"

require "bundler/setup"
Bundler.require(:default, :test)

require "minitest/spec"
require "minitest/autorun"

require_relative "../lib/facts"

class MiniTest::Spec
  include RR::Adapters::TestUnit
end

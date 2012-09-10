require "bundler/setup"
Bundler.require(:default, :test)

require "minitest/spec"
require "minitest/autorun"

require "facts"

class MiniTest::Spec
  include RR::Adapters::TestUnit
end

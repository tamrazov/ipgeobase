# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "ipgeobase"
require "webmock/minitest"

require "minitest/autorun"

class TestCase < Minitest::Test
  def load_fixture(filename)
    File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
  end
end

# frozen_string_literal: true

require "minitest/autorun"
require "peasy_compress"

class TestPeasyCompress < Minitest::Test
  def test_version
    refute_nil PeasyCompress::VERSION
    assert_equal "0.1.1", PeasyCompress::VERSION
  end
end

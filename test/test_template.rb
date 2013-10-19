# coding: utf-8

require 'vernissage'
require 'fileutils'
require 'pathname'
require 'fakefs'
require 'test/unit'

class TestTemplate < Test::Unit::TestCase

  include Vernissage

  class MockTemplate

    def render(&block)
      <<-END
      begin
      #{yield(block)}
      end
      END
    end

  end

  def test_render_template
    expected = <<-END
      begin
      content
      end
    END
    assert_equal(expected, MockTemplate.new().render { |content| "content" })
  end

end

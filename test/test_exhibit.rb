# coding: utf-8

require 'vernissage'
require 'fileutils'
require 'pathname'
require 'fakefs'
require 'test/unit'

class TestExhibit < Test::Unit::TestCase

  include Vernissage

  def test_render
    assert_equal(
      %{<a href="IMG_12345.png"><img src="IMG_12345 small.png" /></a>},
        Exhibit.new(Image.new(Pathname.new("IMG_12345.png")),
                    Image.new(Pathname.new("IMG_12345 small.png"))).render
    )
  end

end

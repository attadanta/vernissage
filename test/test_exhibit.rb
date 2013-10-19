# coding: utf-8

require 'vernissage'
require 'fileutils'
require 'pathname'
require 'fakefs'
require 'test/unit'

class TestExhibit < Test::Unit::TestCase

  include Vernissage

  def test_renders_without_framespec
    assert_equal(
      %{<a href="IMG_12345.png"><img src="IMG_12345 small.png" /></a>},
        Exhibit.new(Image.new(Pathname.new("IMG_12345.png")),
                    Image.new(Pathname.new("IMG_12345 small.png"))).render
    )
  end

  def test_renders_with_framespec
    assert_equal(
      %{<a rel="lightbox[sketches]" class="box" href="IMG_1234.png"><img src="IMG_1234 small.png" /></a>},
      Exhibit.new(Image.new(Pathname.new("IMG_1234.png")),
                  Image.new(Pathname.new("IMG_1234 small.png"))
                 ).render(rel: "lightbox[sketches]", class: "box")
    )
  end

end

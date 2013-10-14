# coding: utf-8

require 'vernissage'
require 'fileutils'
require 'pathname'
require 'fakefs'
require 'test/unit'

class TestFrame < Test::Unit::TestCase

  include Vernissage

  def test_render_anchor
    assert_equal %{<a href="about.html">link</a>},
      Frame.new("a", "link", href: "about.html").render
  end

  def test_render_nested_frame
    assert_equal %{<a href="about.html"><span>about</span></a>},
      Frame.new("a", Frame.new("span", "about"), href: "about.html").render
  end

  def test_image_renders_with_empty_closing_tag
    assert_equal %{<img src="image.png" />},
      ImageFrame.new("image.png").render
  end

end

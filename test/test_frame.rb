# coding: utf-8

require 'vernissage'
require 'fileutils'
require 'pathname'
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

  def test_is_compound
    frame = Frame.new("a", Frame.new("span", "about"), href: "about.html")
    assert frame.is_compound?
  end

  def test_is_not_compound
    frame = Frame.new("a", "link", href: "about.html")
    assert !frame.is_compound?
  end

  def test_image_renders_with_empty_closing_tag
    assert_equal %{<img src="image.png" />},
      ImageFrame.new("image.png").render
  end

  def test_sets_levels
    frame = Frame.new("a", "a link", href: "about.html")
    assert_equal 0, frame.level
  end

  def test_sets_levels_of_shallow_contents
    frame = Frame.new("a", Frame.new("span", "about"))
    assert_equal 1, frame.contents.level
  end

  def test_sets_levels_of_deep_contents
    frame = Frame.new("a",
                      Frame.new("span",
                                Frame.new("strong", "bold link")
                               )
                     )
    assert_equal 2, frame.contents.contents.level
  end

end

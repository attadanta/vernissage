# coding: utf-8

require 'vernissage'
require 'test/unit'

class TestVita < Test::Unit::TestCase

  include Vernissage

  def test_parses_header
    assert_equal "Header", Vita.new.parse_header("Header:")
  end

  def test_parses_item
    assert_equal "an item", Vita.new.parse_item(" - an item")
  end

  def test_detects_item_line
    assert Vita.new.is_item_line(" - 2013 - Louvre; exhibition")
  end

  def test_interprets_blank_line_as_false_item_line
    assert !(Vita.new.is_item_line(""))
  end

  def test_interprets_content_line_as_false_item_line
    assert !(Vita.new.is_item_line("lorem ipsum"))
  end

  def test_parses_header_line
    assert Vita.new.is_header_line("Education:")
  end

  def test_interprets_blank_line_as_false_header_line
    assert !(Vita.new.is_header_line(""))
  end

  def test_interprets_content_line_as_false_header_line
    assert !(Vita.new.is_header_line("education"))
  end

  def test_parses_empty_vita
    assert_equal({}, Vita.new.parse(""))
  end

  def test_parses_single_heading
    contents = <<-END
    Expertise:
     - been there
     - done that
    END
    expected = { "Expertise" => [ 'been there', 'done that' ] }
    assert_equal expected, Vita.new.parse(contents)
  end

  def test_parses_ignores_gaps
    contents = <<-END
    Expertise:

     - been there
     - done that
    END
    expected = { "Expertise" => [ 'been there', 'done that' ] }
    assert_equal expected, Vita.new.parse(contents)
  end

  def test_parses_multiple_headings
    contents = <<-END
    Life:

     - I am an orphan
     - on God's highway

    On the bright side:

     - I have had friendships
     - pure and golden
    END
    expected = {
      "Life" => [ "I am an orphan", "on God's highway" ],
      "On the bright side" => [ 'I have had friendships', 'pure and golden' ]
    }
    assert_equal expected, Vita.new.parse(contents)
  end

end

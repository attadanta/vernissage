# coding: utf-8

require 'vernissage'
require 'test/unit'

class TestVita < Test::Unit::TestCase

  include Vernissage

  def test_detects_item_line
    assert Vita.new.is_item_line(" - 2013 - Louvre; exhibition")
  end

  def test_detects_blank_line_as_false_item_line
    assert !(Vita.new.is_item_line(""))
  end

  def test_detects_content_line_as_false_item_line
    assert !(Vita.new.is_item_line("lorem ipsum"))
  end

  def test_detects_header_line
    assert Vita.new.is_header_line("Education:")
  end

  def test_detects_blank_line_as_false_header_line
    assert !(Vita.new.is_header_line(""))
  end

  def test_detects_content_line_as_false_header_line
    assert !(Vita.new.is_header_line("education"))
  end

end

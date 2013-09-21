# coding: utf-8

require 'vernissage'
require 'test/unit'

class TestImage < Test::Unit::TestCase

  include Vernissage

  def test_init
    assert_not_nil Image.new('file.jpeg')
  end

  def test_related_to_smaller_image
    assert Image.new('file.jpeg').related_to? Image.new('file small.jpeg')
  end

end

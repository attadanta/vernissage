# coding: utf-8

require 'vernissage'
require 'test/unit'

class TestImage < Test::Unit::TestCase

  def test_init
    assert_not_nil Vernissage::Image.new('file.jpeg')
  end

end

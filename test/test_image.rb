# coding: utf-8

require 'vernissage'
require 'pathname'
require 'test/unit'

class TestImage < Test::Unit::TestCase

  include Vernissage

  def test_is_false_image
    assert !(Image.is_image? 'image.doc')
    assert !(Image.is_image? 'image.txt')
    assert !(Image.is_image? Pathname.new('images'))
  end

  def test_is_image
    assert Image.is_image? 'image.jpeg'
    assert Image.is_image? 'image.jpg'
    assert Image.is_image? 'image.png'
    assert Image.is_image? 'image.gif'
  end

  def test_init
    assert_not_nil Image.new('image.jpeg')
    assert_not_nil Image.new(Pathname.new('image.jpg'))
  end

  def test_basename
    assert_equal 'IMG_0508', Image.new('IMG_0508').basename
    assert_equal 'IMG_0494 copy', Image.new('IMG_0494 copy.jpg').basename
    assert_equal 'P1050541 copy', Image.new('P1050541 copy.jpg').basename
  end

  def test_fragments
    assert_equal [ 'img_0508' ], Image.new('img_0508').name_fragments
    assert_equal %w{img_0508 copy}, Image.new('IMG_0508 copy').name_fragments
  end

  def name_has_multiple_fragments
    assert Image.new('IMG_0508 copy').name_has_multiple_fragments?
    assert !Image.new('IMG_0508').name_has_multiple_fragments?
  end

  def test_related_to_smaller_image
    assert Image.new('file.jpeg').related_to? Image.new('file small.jpeg')
  end

  def test_related_to_smaller_image_multiple_names
    assert Image.new('img one.jpeg').related_to? Image.new('img one small.jpeg')
  end

  def test_related_to_copy
    assert Image.new('09062012967.jpeg').related_to? Image.new('09062012967 copy.jpg')
  end

  def test_false_similarity
    assert !(Image.new('IMG_0508.jpeg').related_to? Image.new('IMG_0509.jpeg'))
  end

end

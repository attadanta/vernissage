# coding: utf-8

require 'test/unit'
require 'vernissage'
require 'fileutils'
require 'pathname'
require 'fakefs'

class TestVernissage < Test::Unit::TestCase

  include Vernissage

  def setup
    @orig_paintings = File.join("images", "paintings")
    @small_paintings = File.join("images", "small paintings")
    FileUtils.mkdir_p(@orig_paintings)
    FileUtils.mkdir_p(@small_paintings)
    FileUtils.touch(File.join(@orig_paintings, "IMG_0458.jpg"))
    FileUtils.touch(File.join(@orig_paintings, "IMG_0460.jpg"))
    FileUtils.touch(File.join(@orig_paintings, "IMG_0461.jpg"))
    FileUtils.touch(File.join(@orig_paintings, "IMG_0462.jpg"))
    FileUtils.touch(File.join(@small_paintings, "IMG_0458 copy.jpg"))
    FileUtils.touch(File.join(@small_paintings, "IMG_0460 copy.jpg"))
    FileUtils.touch(File.join(@small_paintings, "IMG_0461 copy.jpg"))
    FileUtils.touch(File.join(@small_paintings, "IMG_0463 copy.jpg"))
  end

  def test_matches_images
    expecteds = [
      [
        Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0458.jpg"))),
        Image.new(Pathname.new(File.join(@small_paintings, "IMG_0458 copy.jpg")))
      ],
      [
        Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0460.jpg"))),
        Image.new(Pathname.new(File.join(@small_paintings, "IMG_0460 copy.jpg")))
      ],
      [
        Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0461.jpg"))),
        Image.new(Pathname.new(File.join(@small_paintings, "IMG_0461 copy.jpg")))
      ],
      [
        Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0462.jpg"))),
        nil
      ],
      [
        nil,
        Image.new(Pathname.new(File.join(@small_paintings, "IMG_0463 copy.jpg")))
      ]
    ]

    actuals = Vernissage::match_images(Pathname.new(@orig_paintings),
                                       Pathname.new(@small_paintings))
    assert_equal expecteds, actuals
  end

  def test_finds_l_unmatched
    expecteds = [ Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0462.jpg"))) ]
    actuals = Vernissage::find_unmatched_originals(
      Vernissage::match_images(
        Pathname.new(@orig_paintings),
        Pathname.new(@small_paintings)
      )
    )
    assert_equal expecteds, actuals
  end

  def test_finds_r_unmatched
    expecteds = [ Image.new(Pathname.new(File.join(@small_paintings, "IMG_0463 copy.jpg"))) ]
    actuals = Vernissage::find_unmatched_thumbnails(
      Vernissage::match_images(
        Pathname.new(@orig_paintings),
        Pathname.new(@small_paintings)
      )
    )
    assert_equal expecteds, actuals
  end
end

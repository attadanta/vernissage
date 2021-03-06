# coding: utf-8

require 'test/unit'
require 'fakefs/safe'

require 'fileutils'
require 'pathname'

require 'vernissage'

class TestVernissage < Test::Unit::TestCase

  include Vernissage

  def setup
    FakeFS.activate!

    @orig_paintings = File.join("images", "paintings")
    @small_paintings = File.join("images", "small paintings")

    FileUtils.mkdir_p(@orig_paintings)
    FileUtils.mkdir_p(@small_paintings)

    FileUtils.touch(File.join(@orig_paintings, "IMG_0458.JPG"))
    FileUtils.touch(File.join(@orig_paintings, "IMG_0460.JPG"))
    FileUtils.touch(File.join(@orig_paintings, "IMG_0461.jpg"))
    FileUtils.touch(File.join(@orig_paintings, "IMG_0462.jpg"))
    FileUtils.touch(File.join(@orig_paintings, "list.txt"))

    FileUtils.touch(File.join(@small_paintings, "IMG_0458 copy.jpg"))
    FileUtils.touch(File.join(@small_paintings, "IMG_0460 copy.jpg"))
    FileUtils.touch(File.join(@small_paintings, "IMG_0461 copy.jpg"))
    FileUtils.touch(File.join(@small_paintings, "IMG_0463 copy.jpg"))
    FileUtils.touch(File.join(@small_paintings, "misc.txt"))
  end

  def teardown
    FakeFS.deactivate!
  end

  def test_finds_positive_match
    potentials = [
      Image.new(Pathname.new(File.join(@small_paintings, "IMG_0458 copy.jpg"))),
      Image.new(Pathname.new(File.join(@small_paintings, "IMG_0460 copy.jpg"))),
      Image.new(Pathname.new(File.join(@small_paintings, "IMG_0461 copy.jpg")))
    ]

    test_case = Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0458.JPG")))

    assert_equal(
      Image.new(Pathname.new(File.join(@small_paintings, "IMG_0458 copy.jpg"))),
      test_case.find_match(potentials)
    )
  end

  def test_matches_images
    expecteds = [
      Exhibit.new(
        Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0458.JPG"))),
        Image.new(Pathname.new(File.join(@small_paintings, "IMG_0458 copy.jpg")))
      ),
      Exhibit.new(
        Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0460.JPG"))),
        Image.new(Pathname.new(File.join(@small_paintings, "IMG_0460 copy.jpg")))
      ),
      Exhibit.new(
        Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0461.jpg"))),
        Image.new(Pathname.new(File.join(@small_paintings, "IMG_0461 copy.jpg")))
      )
    ]

    actuals = Curation.new(Pathname.new(@orig_paintings),
                           Pathname.new(@small_paintings)).exhibits

    assert_equal expecteds, actuals
  end

  def test_finds_unmatched_originals
    expecteds = [ Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0462.jpg"))) ]

    actuals = Curation.new(Pathname.new(@orig_paintings),
                           Pathname.new(@small_paintings)).find_unmatched_originals

    assert_equal expecteds, actuals
  end

  def test_finds_unmatched_thumbnails
    expecteds = [ Image.new(Pathname.new(File.join(@small_paintings, "IMG_0463 copy.jpg"))) ]

    actuals = Curation.new(Pathname.new(@orig_paintings),
                           Pathname.new(@small_paintings)).find_unmatched_thumbnails

    assert_equal expecteds, actuals
  end

  def test_generates_exhibits_list
    expecteds = [
      Exhibit.new(
        Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0458.JPG"))),
        Image.new(Pathname.new(File.join(@small_paintings, "IMG_0458 copy.jpg")))
      ),
      Exhibit.new(
        Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0460.JPG"))),
        Image.new(Pathname.new(File.join(@small_paintings, "IMG_0460 copy.jpg")))
      ),
      Exhibit.new(
        Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0461.jpg"))),
        Image.new(Pathname.new(File.join(@small_paintings, "IMG_0461 copy.jpg")))
      )
    ]

    actuals = Curation.new(Pathname.new(@orig_paintings),
                           Pathname.new(@small_paintings)).exhibits

    assert_equal expecteds, actuals
  end

  def test_enumerates_original_images
    instance = Curation.new(Pathname.new(@orig_paintings),
                            Pathname.new(@small_paintings))

    expecteds = [
      Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0458.JPG"))),
      Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0460.JPG"))),
      Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0461.jpg"))),
      Image.new(Pathname.new(File.join(@orig_paintings, "IMG_0462.jpg")))
    ]

    assert_equal expecteds, instance.original_images
  end

  def test_enumerates_thumbs
    instance = Curation.new(Pathname.new(@orig_paintings),
                            Pathname.new(@small_paintings))
    expecteds = [
      Image.new(Pathname.new(File.join(@small_paintings, "IMG_0458 copy.jpg"))),
      Image.new(Pathname.new(File.join(@small_paintings, "IMG_0460 copy.jpg"))),
      Image.new(Pathname.new(File.join(@small_paintings, "IMG_0461 copy.jpg"))),
      Image.new(Pathname.new(File.join(@small_paintings, "IMG_0463 copy.jpg")))
    ]

    assert_equal expecteds, instance.thumbnails
  end

end

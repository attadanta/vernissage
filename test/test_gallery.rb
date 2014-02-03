# coding: utf-8

require 'vernissage'
require 'fileutils'
require 'pathname'
require 'fakefs/safe'
require 'test/unit'

class TestGallery < Test::Unit::TestCase

  include Vernissage

  def setup
    FakeFS.activate!
  end

  def teardown
    FakeFS.deactivate!
  end

  def test_name_from_path
    assert_equal "Sketches", Gallery.new(Pathname.new(File.join("galleries", "Sketches"))).name
  end

  def test_related_to_other_gallery
    assert(
      Gallery.new(Pathname.new(File.join("images", "Paintings"))).related_to?(
      Gallery.new(Pathname.new(File.join("images", "small paintings"))))
    )
  end

end

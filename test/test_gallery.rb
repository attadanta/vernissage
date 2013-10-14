# coding: utf-8

require 'vernissage'
require 'fileutils'
require 'pathname'
require 'fakefs'
require 'test/unit'

class TestGallery < Test::Unit::TestCase

  include Vernissage

  def test_name_from_path
    assert_equal "Sketches", Gallery.new(Pathname.new(File.join("galleries", "Sketches"))).name
  end

end

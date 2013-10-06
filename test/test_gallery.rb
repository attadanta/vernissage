# coding: utf-8

require 'vernissage'
require 'fileutils'
require 'pathname'
require 'fakefs'
require 'test/unit'

class TestGallery < Test::Unit::TestCase

  include Vernissage

  def test_creates_gallery_from_dirnames
    FileUtils.mkdir('galleries')
    expecteds = %w{ Drawings Paintings Sketches }
    expecteds.each do |name|
      FileUtils.mkdir(File.join('galleries', name))
    end
    actuals = Curator.new('galleries').galleries.collect do |gal|
      gal.name
    end.sort
    assert_equal expecteds, actuals
  end

end

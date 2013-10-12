# coding: utf-8

require 'vernissage'
require 'fileutils'
require 'pathname'
require 'fakefs'
require 'test/unit'

class TestGallery < Test::Unit::TestCase

  include Vernissage

  def initialize(path)
    @path = Pathname.new(path)
  end

  def galleries
    @path.children.collect { |item| Gallery.new(item.basename.to_s) }
  end

end

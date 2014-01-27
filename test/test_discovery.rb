# coding: utf-8

require 'vernissage'
require 'test/unit'

class TestDiscovery < Test::Unit::TestCase

  include Vernissage

  def setup
    FakeFS.activate!

    FileUtils.mkdir_p(File.join("discovery", "images", "paintings"))
    FileUtils.mkdir_p(File.join("discovery", "images", "drawings"))
    FileUtils.mkdir_p(File.join("discovery", "thumbs", "small paintings"))
  end

  def teardown
    FakeFS.deactivate!
  end

  def test_detects_mismatches
    curations = Discovery.new(
      Pathname.new(File.join('discovery', 'images')),
      Pathname.new(File.join('discovery', 'thumbs'))
    ).curations

    assert_equal(1, curations.size)
  end

end

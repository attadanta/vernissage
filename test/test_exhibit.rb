# coding: utf-8

require 'vernissage'
require 'fileutils'
require 'pathname'
require 'fakefs/safe'
require 'test/unit'

class TestExhibit < Test::Unit::TestCase

  include Vernissage

  def setup
    FakeFS.activate!
  end

  def teardown
    FakeFS.deactivate!
  end

end

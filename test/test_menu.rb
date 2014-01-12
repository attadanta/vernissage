# coding: utf-8

require 'vernissage'
require 'test/unit'
require 'haml'

class TestMenu < Test::Unit::TestCase

  include Vernissage

  def setup
    @fixtures = File.join(Pathname.new(__FILE__).dirname, 'fixtures')
    @galleries = [
      Gallery.new(Pathname.new('drawings')),
      Gallery.new(Pathname.new('sketches'))
    ]
  end

  def test_fixture
    template = File.read(File.join(@fixtures, 'menu.haml'))
    expected = File.read(File.join(@fixtures, 'menu.html'))

    engine = Haml::Engine.new(template)

    assert_equal(expected, engine.render(self))
  end

end

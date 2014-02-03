# coding: utf-8

require 'vernissage'

class TestFinissage < Test::Unit::TestCase

  include Vernissage

  def setup
    FakeFS.activate!

    @fixtures = Pathname.new(
      File.join(Pathname.new(__FILE__).dirname, 'fixtures'))

    @orig_paintings = File.join("originals", "paintings")
    @small_paintings = File.join("thumbs", "small paintings")

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

    discovery = Discovery.new(Pathname.new('originals'), Pathname.new('thumbs'))

    bio = @fixtures.join(Pathname.new('bio.mdwn'))
    contact = @fixtures.join(Pathname.new('contact.mdwn'))

    template = @fixtures.join(Pathname.new('template.haml'))

    @vernissage = Finissage.new(discovery, bio, contact, template)
  end

  def teardown
    FakeFS.deactivate!
  end

  def test_init
    assert_not_nil @vernissage
  end

  def test_education
    actual = [ '2008 – current: Lycée Français' ]
    assert_equal(actual, @vernissage.education)
  end

end

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

  def test_render
    gallery = Gallery.new(Pathname.new(File.join("images", "Paintings")))
    gallery.add_exhibit(
      Exhibit.new(
        Image.new(Pathname.new("IMG_1.png")),
        Image.new(Pathname.new("IMG_1 small.png"))
      )
    )
    gallery.add_exhibit(
      Exhibit.new(
        Image.new(Pathname.new("IMG_2.png")),
        Image.new(Pathname.new("IMG_2 small.png"))
      )
    )
    expected = <<-END
      <section id="paintings">
        <div class="gallery">
          <h1>Paintings</h1>
          <a href="IMG_1.png"><img src="IMG_1 small.png" /></a>
          <a href="IMG_2.png"><img src="IMG_2 small.png" /></a>
        </div>
      </section>
    END
    assert_equal(expected, gallery.render)
  end

end

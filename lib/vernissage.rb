$:.unshift File.dirname(__FILE__)

require 'vernissage/frame'
require 'vernissage/curator'
require 'vernissage/image'
require 'vernissage/exhibit'
require 'vernissage/gallery'

# A simple web gallery processor. Made for http://plamenmadjarovart.com
module Vernissage
  def Vernissage::match_images(path_to_originals, path_to_thumbnails)
    []
  end
end

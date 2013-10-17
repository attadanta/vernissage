$:.unshift File.dirname(__FILE__)

require 'vernissage/frame'
require 'vernissage/curator'
require 'vernissage/image'
require 'vernissage/exhibit'
require 'vernissage/gallery'

# A simple web gallery processor. Made for http://plamenmadjarovart.com
module Vernissage

  def Vernissage::match_images(path_to_originals, path_to_thumbnails)
    pairs = []
    originals = path_to_originals.children
    thumbnails = path_to_thumbnails.children
    until originals.empty? do
      left_candidate = Image.new(originals.shift)
      match = thumbnails.index do |thumb|
        left_candidate.related_to? Image.new(thumb)
      end
      unless match.nil?
        pairs.push [ left_candidate, Image.new(thumbnails.slice!(match)) ]
      else
        pairs.push [ left_candidate, match ]
      end
    end
    thumbnails.each { |thumb| pairs.push [ nil, Image.new(thumb) ] }
    pairs
  end

  def Vernissage::find_unmatched_originals(pairs)
    pairs.select { |pair| pair[1].nil? }.map { |pair| pair[0] }
  end

  def Vernissage::find_unmatched_thumbnails(pairs)
    pairs.select { |pair| pair[0].nil? }.map { |pair| pair[1] }
  end

end

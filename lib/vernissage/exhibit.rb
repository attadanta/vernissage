# coding: utf-8

module Vernissage

  # An exhibit is a pair of images linking an original with its thumbnail.
  class Exhibit

    # The original image.
    #
    # @return [Vernissage::Image] the original image.
    attr_reader :original_image

    # The image thumbnail.
    #
    # @return [Vernissage::Image] the thumbnail.
    attr_reader :thumbnail

    # Class constructor.
    #
    # @param [Vernissage::Image] original_image the original image.
    # @param [Vernissage::Image] thumbnail the image thumbnail.
    def initialize(original_image, thumbnail)
      @original_image = original_image
      @thumbnail = thumbnail
    end

    # Equality check.
    #
    # @param [Vernissage::Exhibit] other other exhibit.
    def ==(other)
      @original_image == other.original_image &&
        @thumbnail == other.thumbnail
    end

  end

end

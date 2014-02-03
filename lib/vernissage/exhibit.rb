# coding: utf-8

module Vernissage

  # An exhibit is a pair of images linking an original with its thumbnail.
  class Exhibit

    attr_reader :original_image, :thumbnail

    # Class constructor
    #
    # @param [Pathname] original_image  a path to the original image.
    # @param [Pathname] thumbnail a path to the image thumbnail.
    def initialize(original_image, thumbnail)
      @original_image = original_image
      @thumbnail = thumbnail
    end

    def render(framespec={})
      Frame.new("a",
                ImageFrame.new(@thumbnail.path.to_s),
                framespec.merge(href: @original_image.path.to_s)
               ).render
    end

    def ==(other)
      @original_image == other.original_image &&
        @thumbnail == other.thumbnail
    end

  end

end

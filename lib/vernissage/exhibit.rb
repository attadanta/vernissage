# coding: utf-8

module Vernissage

  class Exhibit

    attr_reader :original_image, :thumbnail

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

  end

end

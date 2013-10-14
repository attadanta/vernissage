# coding: utf-8

module Vernissage

  class Exhibit

    attr_reader :original_image, :thumbnail

    def initialize(original_image, thumbnail, framespec={})
      @original_image = original_image
      @thumbnail = thumbnail
      @framespec = framespec.merge href: @original_image.path.to_s
    end

    def render
      Frame.new("a", ImageFrame.new(@thumbnail.path.to_s), @framespec).render
    end

  end

end

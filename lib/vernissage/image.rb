# coding: utf-8

module Vernissage

  class Image

    def initialize(path)
      @path = path
    end

    def related_to?(image)
      false
    end

  end

end

# coding: utf-8
require 'pathname'

module Vernissage

  class Image

    include Curator

    class << self

      IMAGE_EXTENSIONS = %w{ .gif .jpg .jpeg .png }

      def is_image?(path)
        IMAGE_EXTENSIONS.include? Pathname.new(path).extname.downcase
      end

    end

    attr_reader :path

    def initialize(path)
      @path = Pathname.new(path)
    end

  end

end

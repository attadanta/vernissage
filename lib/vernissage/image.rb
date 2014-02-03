# coding: utf-8
require 'pathname'

module Vernissage

  class Image

    include Curator

    class << self

      # Lists the supported image formats.
      IMAGE_EXTENSIONS = %w{ .gif .jpg .jpeg .png }

      # Returns `true`, if the given file is a supported image and `false`
      # otherwise.
      #
      # @param [String, Pathname] path file path.
      def is_image?(path)
        IMAGE_EXTENSIONS.include? Pathname.new(path).extname.downcase
      end

    end

    attr_reader :path

    # Image constructor.
    #
    # @param [String, Pathname] path image path.
    def initialize(path)
      @path = Pathname.new(path)
    end

  end

end

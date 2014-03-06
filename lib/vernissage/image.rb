# coding: utf-8

module Vernissage
  # An image file abstraction.
  class Image
    include Comparable

    class << self
      # Lists the supported image formats.
      IMAGE_EXTENSIONS = %w{ .gif .jpg .jpeg .png }

      # Returns `true`, if the given file is a supported image and `false`
      # otherwise.
      #
      # @param [String, Pathname] path file path.
      def image?(path)
        IMAGE_EXTENSIONS.include? Pathname.new(path).extname.downcase
      end
    end

    # Image path
    # @return [Pathname]
    attr_reader :path

    # Image constructor.
    #
    # @param [String, Pathname] path image path.
    def initialize(path)
      @path = Pathname.new(path)
    end
  end
end

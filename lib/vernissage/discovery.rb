# coding: utf-8
module Vernissage

  # Discovery handles the image matching on the directory level.
  class Discovery

    include Vernissage::Curator

    attr_reader :path_to_originals
    attr_reader :path_to_thumbnails

    # Class constructor.
    #
    # @param [Pathname] path_to_originals must exist.
    # @param [Pathname] path_to_thumbnails must exist.
    def initialize(path_to_originals, path_to_thumbnails)
      @path_to_originals = path_to_originals
      @path_to_thumbnails = path_to_thumbnails
    end

    # Returns the galleries under the originals directory.
    #
    # @return [Array<Vernissage::Gallery>] the galleries from the originals
    #   directory.
    def originals
      subdirectories(@path_to_originals).map { |path| Gallery.new(path) }
    end

    # Returns the galleries under the thumbnails directory.
    #
    # @return [Array<Vernissage::Gallery>] thumbnail galleries.
    def thumbnails
      subdirectories(@path_to_thumbnails).map { |path| Gallery.new(path) }
    end

    # Collects {Curation}s after matching the galleries from the originals and
    # thumbnails directories.
    #
    # @return [Array<Vernissage::Curation>] gallery curations.
    def curations
      full_pairs.map { |pair| Curation.new(pair[0].path, pair[1].path) }
    end

    # Equality check.
    #
    # @param [Discovery] other the object to check against.
    #
    # @return [Boolean]
    def ==(other)
      if other.kind_of? Discovery
        other.path_to_originals == @path_to_originals and
          other.path_to_thumbnails == @path_to_thumbnails
      else
        false
      end
    end

    # Returns a developer friendly representation of the object.
    #
    # return [String]
    def inspect
      "#<Vernissage::Discovery originals:#{@path_to_originals.inspect} thumbs:#{@path_to_thumbnails.inspect}>"
    end

    private

    alias :original_items :originals

    alias :thumbnail_items :thumbnails

    def subdirectories(path)
      path.children.select { |child| child.directory? }
    end

  end

end

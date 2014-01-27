# coding: utf-8
module Vernissage

  # Discovery handles directories matching by generating curations.
  class Discovery

    attr_reader :path_to_originals
    attr_reader :path_to_thumbnails

    def initialize(path_to_originals, path_to_thumbnails)
      @path_to_originals = path_to_originals
      @path_to_thumbnails = path_to_thumbnails
    end

    def originals
      subdirectories(@path_to_originals).map { |path| Gallery.new(path) }
    end

    def thumbnails
      subdirectories(@path_to_thumbnails).map { |path| Gallery.new(path) }
    end

    def curations
      curations = []

      originals.each do |original|
        thumb_match = original.find_match(thumbnails)
        unless thumb_match.nil?
          curations << Curation.new(original.path, thumb_match.path)
        end
      end

      curations
    end

    def ==(other)
      if other.kind_of? Discovery
        other.path_to_originals == @path_to_originals and
          other.path_to_thumbnails == @path_to_thumbnails
      else
        false
      end
    end

    def to_s
      "Vernissage::Discovery{ originals=" + @path_to_originals.to_s + " thumbs=" + @path_to_thumbnails.to_s + " }"
    end

    private

    def subdirectories(path)
      path.children.select { |child| child.directory? }
    end

  end

end

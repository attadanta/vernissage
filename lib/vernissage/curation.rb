# coding: utf-8
require 'pathname'

module Vernissage

  # Curation matches images placed in two directories. The first directory
  # contains the original images and the second contains the thumbnails. Image
  # matching is based on filenames. Curation generates the galleries on the
  # site.
  class Curation

    attr_reader :path_to_originals
    attr_reader :path_to_thumbnails

    # Class constructor.
    #
    # @param path_to_originals [Pathname] a directory containing the original,
    #   full-size images. Must exist.
    # @param path_to_thumbnails [Pathname] directory containing the image
    #   thumbnails. Must exist.
    def initialize(path_to_originals, path_to_thumbnails)
      @path_to_originals = path_to_originals
      @path_to_thumbnails = path_to_thumbnails
      @pairs = match_images
    end

    # Collects all unmatched original images.
    #
    # @return [Array<Vernissage::Image>] a list of images.
    def find_unmatched_originals
      find_matches.select { |pair| pair[1].nil? }.map { |pair| pair[0] }
    end

    # Collects all unmatched thumbnails.
    #
    # @return [Array<Vernissage::Image>] a list of images.
    def find_unmatched_thumbnails
      find_matches.select { |pair| pair[0].nil? }.map { |pair| pair[1] }
    end

    # Returns `true`, if there are unmatched images from the originals
    #   directory, and `false` otherwise.
    def any_unmatched_original_images?
      not find_unmatched_originals.empty?
    end

    # Returns `true`, if there are unmatched images from the thumbnails
    #   directory, and `false` otherwise.
    def any_unmatched_thumbnails?
      not find_unmatched_thumbnails.empty?
    end

    # Collects all image pairs (matched and non-matched) found in the images
    # directories.
    #
    # @return [Array<Array>] a list of tuples in the form [original, thumb]. A
    #   nil in the respective field indicates a missing match.
    def find_matches
      @pairs.dup
    end

    # Collects the matched images in a Gallery. The name of the gallery is
    # taken from the directory name of the path to the original images.
    #
    # @return [Vernissage::Gallery] a Gallery instance with all matched images.
    def to_gallery
      gallery = Gallery.new(@path_to_originals)

      exhibits.each do |exhibit|
        gallery.add_exhibit exhibit
      end

      gallery
    end

    # Returns an array of matched images.
    #
    # @return [Array<Vernissage::Exhibit>] a list of exhibits.
    def exhibits
      find_matches.reject do |pair|
        pair[0].nil? or pair[1].nil?
      end.map do |pair|
        Exhibit.new(pair[0], pair[1])
      end
    end

    # Returns all images contained in the thumbnails directory.
    #
    # @return [Array<Vernissage::Image>] a list of images.
    def thumbnails
      select_images(@path_to_thumbnails)
    end

    # Returns all images contained in the originals directory.
    #
    # @return [Array<Vernissage::Image>] a list of images.
    def original_images
      select_images(@path_to_originals)
    end

    private

    def match_images
      pairs = []

      originals = original_images
      thumbs = thumbnails

      until originals.empty? do
        left_candidate = originals.shift
        match = thumbs.index do |thumb|
          left_candidate.related_to? thumb
        end
        unless match.nil?
          pairs.push [ left_candidate, thumbs.slice!(match) ]
        else
          pairs.push [ left_candidate, match ]
        end
      end
      thumbs.each { |thumb| pairs.push [ nil, thumb ] }

      pairs
    end

    def select_images(directory)
      directory.children.select do |file|
        not file.basename.to_s.start_with?('.') and Image.is_image? file
      end.map do |entry|
        Image.new(entry)
      end
    end

  end

end

# coding: utf-8
require 'pathname'

module Vernissage
  # Curation matches images placed in two directories. The first directory
  # contains the original images and the second contains the thumbnails. Image
  # matching is based on filenames. Curation generates the galleries on the
  # site.
  class Curation
    include Curator

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
    end

    # Collects all unmatched original images.
    #
    # @return [Array<Vernissage::Image>] a list of images.
    def find_unmatched_originals
      match_items.select { |pair| pair[1].nil? }.map { |pair| pair[0] }
    end

    # Collects all unmatched thumbnails.
    #
    # @return [Array<Vernissage::Image>] a list of images.
    def find_unmatched_thumbnails
      match_items.select { |pair| pair[0].nil? }.map { |pair| pair[1] }
    end

    # Returns `true`, if there are unmatched images from the originals
    #   directory, and `false` otherwise.
    def any_unmatched_original_images?
      !find_unmatched_originals.empty?
    end

    # Returns `true`, if there are unmatched images from the thumbnails
    #   directory, and `false` otherwise.
    def any_unmatched_thumbnails?
      !find_unmatched_thumbnails.empty?
    end

    # Collects the matched images in a Gallery. The name of the gallery is
    # taken from the directory name of the path to the original images.
    #
    # @return [Vernissage::Gallery] a Gallery instance with all matched images.
    def to_gallery
      Gallery.new(@path_to_originals, exhibits)
    end

    # Returns an array of matched images.
    #
    # @return [Array<Vernissage::Exhibit>] a list of exhibits.
    def exhibits
      full_pairs.map do |pair|
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

    def select_images(directory)
      directory.children.select do |file|
        !file.basename.to_s.start_with?('.') && Image.image?(file)
      end.map do |entry|
        Image.new(entry)
      end
    end

    alias_method :original_items, :original_images
    alias_method :thumbnail_items, :thumbnails
  end
end

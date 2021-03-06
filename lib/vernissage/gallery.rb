# coding: utf-8
require 'pathname'

module Vernissage
  # A gallery is a directory abstraction. Collects all matched images
  # (exhibits).
  class Gallery
    include Comparable

    # The gallery's path.
    #
    # @return [Pathname] path to the gallery's original images.
    attr_reader :path

    # The gallery's name.
    #
    # @return [String]
    attr_reader :name

    # Gallery constructor.
    #
    # @param [Pathname] path a the directory path to the original images.
    # @param [Array<Vernissage::Exhibit>] exhibits a list of exhibits.
    def initialize(path, exhibits = [])
      @path = path
      @name = path.basename.to_s.capitalize
      @exhibits = exhibits
    end

    # Adds an exhibit to this gallery.
    #
    # @param [Vernissage::Exhibit] exhibit
    def add_exhibit(exhibit)
      @exhibits.push exhibit
    end

    # The gallery's exhibits.
    #
    # @return [Array<Vernissage::Exhibit>]
    def exhibits
      @exhibits.dup
    end
  end
end

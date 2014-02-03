# coding: utf-8
require 'pathname'

module Vernissage

  # A gallery is a directory abstraction.
  class Gallery

    include Curator

    attr_reader :path
    attr_reader :name
    attr_reader :exhibits

    # Class constructor.
    #
    # @param [Pathname] path a the directory path to the original images.
    def initialize(path)
      @path = path
      @name = path.basename.to_s.capitalize
      @exhibits = []
    end

    # Adds an exhibit to this gallery.
    #
    # @param [Vernissage::Exhibit] exhibit
    def add_exhibit(exhibit)
      @exhibits.push exhibit
    end

  end

end

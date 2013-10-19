# coding: utf-8
require 'pathname'

module Vernissage

  class Gallery

    include Curator

    attr_reader :path
    attr_reader :name

    def initialize(path)
      @path = path
      @name = path.basename.to_s.capitalize
      @exhibits = []
    end

    def add_exhibit(exhibit)
      @exhibits.push exhibit
    end

  end

end

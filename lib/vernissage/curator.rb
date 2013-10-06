# coding: utf-8
require 'pathname'

module Vernissage

  class Curator

    def initialize(path)
      @path = Pathname.new(path)
    end

    def galleries
      @path.children.collect { |item| Gallery.new(item.basename.to_s) }
    end

  end

end

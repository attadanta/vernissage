# coding: utf-8
require 'pathname'

module Vernissage

  class Image

    attr_reader :path

    def initialize(path)
      @path = Pathname.new(path)
    end

    def basename
      @path.basename(@path.extname).to_s
    end

    def name_fragments
      basename.split(' ')
    end

    def name_has_multiple_fragments?
      name_fragments.size > 1
    end

    def related_to?(image)
      if self.name_has_multiple_fragments?
        image.name_contained_in_fragments? self.name_fragments
      else
        self.name_contained_in_fragments? image.name_fragments
      end
    end

    protected

    def name_contained_in_fragments?(fragments)
      fragments.include? self.basename
    end

  end

end

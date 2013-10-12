# coding: utf-8
require 'pathname'

module Vernissage

  module Curator

    def basename
      self.path.basename(self.path.extname).to_s
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

    def ==(other)
      if other.respond_to? :path
        self.path == other.path
      else
        false
      end
    end

    protected

    def name_contained_in_fragments?(fragments)
      fragments.include? self.basename
    end

  end

end

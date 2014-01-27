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

    def find_match(objects)
      objects.find { |object| object.related_to? self }
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
        self.path.basename == other.path.basename
      else
        false
      end
    end

    protected

    def name_contained_in_fragments?(fragments)
      fragments.map do |f|
        f.downcase
      end.include? self.basename.downcase
    end

  end

end

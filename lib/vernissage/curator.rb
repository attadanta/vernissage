# coding: utf-8
require 'pathname'

module Vernissage

  module Curator

    def basename
      self.path.basename(self.path.extname).to_s
    end

    def name_fragments
      basename.split(' ').map { |fragment| fragment.downcase }
    end

    def name_has_multiple_fragments?
      name_fragments.size > 1
    end

    def find_match(objects)
      objects.find { |object| object.related_to? self }
    end

    def related_to?(image)
      not (self.name_fragments & image.name_fragments).empty?
    end

    def ==(other)
      if other.respond_to? :path
        self.path.basename == other.path.basename
      else
        false
      end
    end

  end

end

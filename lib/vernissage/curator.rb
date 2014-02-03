# coding: utf-8
require 'pathname'

module Vernissage

  # A mixin providing comparison and relatedness methods. Clients must provide
  # a `path` member or method.
  module Curator

    # @return [String] the basename of this object's path, without the
    #   extension.
    def basename
      self.path.basename(self.path.extname).to_s
    end

    # Returns the fragments of this object's base filename. Fragments are
    # extracted by splitting the {#basename} along a single space and then cast
    # down.
    #
    # @return [Array<String>] name fragments
    def name_fragments
      basename.split(' ').map { |fragment| fragment.downcase }
    end

    # Finds the first curator object in the given array {#related_to?} the
    # receiver.
    #
    # @param [Array<Vernissage::Curator>] objects an array of comparable
    #   objects.
    # @return a related object, if found, or nil otherwise.
    def find_match(objects)
      objects.find { |object| object.related_to? self }
    end

    # Checks if two objects are related. The comparison is established by
    # intersecting their named fragments.
    #
    # @param [Vernissage::Curator] object a comparable object.
    def related_to?(object)
      not (self.name_fragments & object.name_fragments).empty?
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

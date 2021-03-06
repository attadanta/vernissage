# coding: utf-8

module Vernissage
  # A mixin providing comparison and relatedness methods. Clients must provide
  # a `#path` member.
  module Comparable
    # @return [String] the basename of this object's path, without the
    #   extension.
    def basename
      path.basename(path.extname).to_s
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
    # @param [Array<Vernissage::Comparable>] objects an array of comparable
    #   objects.
    # @return a related object, if found, or nil otherwise.
    def find_match(objects)
      objects.find { |object| object.related_to? self }
    end

    # Checks if two objects are related. The comparison is established by
    # intersecting their named fragments.
    #
    # @param [Vernissage::Comparable] object a comparable object.
    def related_to?(object)
      !(name_fragments & object.name_fragments).empty?
    end

    # The equality check is based on the path of the {Curator}.
    #
    # @param [Object, #path] other the object to check equality against.
    def ==(other)
      if other.respond_to? :path
        path.basename == other.path.basename
      else
        false
      end
    end
  end
end

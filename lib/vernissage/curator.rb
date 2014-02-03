# coding: utf-8

module Vernissage

  # A mixin providing the {#match_items} method performing the matching of
  # items across the originals and thumbnails. Clients must implement
  # `original_items` and `thumbnail_items` which return a list of
  # {Vernissage::Comparable}s from the respective directory.
  module Curator

    protected

    def match_items
      pairs = []

      originals = original_items
      thumbs = thumbnail_items

      until originals.empty? do
        left_candidate = originals.shift
        match = thumbs.index do |thumb|
          left_candidate.related_to? thumb
        end
        unless match.nil?
          pairs.push [ left_candidate, thumbs.slice!(match) ]
        else
          pairs.push [ left_candidate, match ]
        end
      end
      thumbs.each { |thumb| pairs.push [ nil, thumb ] }

      pairs
    end

    # Returns a list of pairs with both elements defined, i.e. not null.
    #
    # @return [Array<Array>]
    def full_pairs
      match_items.reject do |pair|
        pair[0].nil? or pair[1].nil?
      end
    end

  end

end

# coding: utf-8

module Vernissage

  # A mixin providing the {#match_items} method. Clients must implement
  # `original_items` and `thumbnail_items`.
  module Curator

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

  end

end

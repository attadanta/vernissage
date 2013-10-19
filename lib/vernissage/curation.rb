# coding: utf-8
require 'pathname'

module Vernissage

  class Curation

    def initialize(path_to_originals, path_to_thumbnails)
      @originals = path_to_originals.children
      @thumbnails = path_to_thumbnails.children
      @pairs = match_images
    end

    def find_unmatched_originals
      @pairs.select { |pair| pair[1].nil? }.map { |pair| pair[0] }
    end

    def find_unmatched_thumbnails
      @pairs.select { |pair| pair[0].nil? }.map { |pair| pair[1] }
    end

    def find_matches
      @pairs.to_ary
    end

    def exhibits
      find_matches.reject do |pair|
        match[0].nil? or match[1].nil?
      end.map do |pair|
        Exhibit.new(match[0], match[1])
      end
    end

    private

    def match_images
      pairs = []
      originals = @originals.map { |entry| Image.new(entry) }
      thumbnails = @thumbnails.map { |entry| Image.new(entry) }
      until originals.empty? do
        left_candidate = originals.shift
        match = thumbnails.index do |thumb|
          left_candidate.related_to? thumb
        end
        unless match.nil?
          pairs.push [ left_candidate, thumbnails.slice!(match) ]
        else
          pairs.push [ left_candidate, match ]
        end
      end
      thumbnails.each { |thumb| pairs.push [ nil, thumb ] }
      pairs
    end

  end

end

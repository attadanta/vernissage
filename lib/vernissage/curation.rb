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

    private

    def match_images
      pairs = []
      originals = @originals.to_ary
      thumbnails = @thumbnails.to_ary
      until originals.empty? do
        left_candidate = Image.new(originals.shift)
        match = thumbnails.index do |thumb|
          left_candidate.related_to? Image.new(thumb)
        end
        unless match.nil?
          pairs.push [ left_candidate, Image.new(thumbnails.slice!(match)) ]
        else
          pairs.push [ left_candidate, match ]
        end
      end
      thumbnails.each { |thumb| pairs.push [ nil, Image.new(thumb) ] }
      pairs
    end

  end

end

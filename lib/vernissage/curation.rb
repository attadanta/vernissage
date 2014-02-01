# coding: utf-8
require 'pathname'

module Vernissage

  class Curation

    def initialize(path_to_originals, path_to_thumbnails)
      @path_to_originals = path_to_originals
      @path_to_thumbnails = path_to_thumbnails
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

    def to_gallery
      gallery = Gallery.new(@path_to_originals)
      exhibits.each do |exhibit|
        gallery.add_exhibit exhibit
      end
      gallery
    end

    def exhibits
      find_matches.reject do |pair|
        pair[0].nil? or pair[1].nil?
      end.map do |pair|
        Exhibit.new(pair[0], pair[1])
      end
    end

    def unmatched_original_images
      find_matches.select do |pair|
        pair[0] != nil and pair[1].nil?
      end.map do |pair|
        pair[0]
      end
    end

    def unmatched_thumbnails
      find_matches.select do |pair|
        pair[0].nil? and pair[1] != nil
      end.map do |pair|
        pair[1]
      end
    end

    def thumbnails
      @path_to_thumbnails.children.map { |entry| Image.new(entry) }
    end

    def original_images
      @path_to_originals.children.map { |entry| Image.new(entry) }
    end

    private

    def match_images
      pairs = []

      originals = original_images
      thumbs = thumbnails

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

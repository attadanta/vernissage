# coding: utf-8

module Vernissage

  class Vita

    def is_item_line(line)
      line.start_with? "\s-"
    end

    def is_header_line(line)
      !is_item_line(line) && line.end_with?(":")
    end

  end

end

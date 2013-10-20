# coding: utf-8

module Vernissage

  class Vita

    def parse_header(line)
      line[0...-1]
    end

    def parse_item(line)
      leader = line =~ /-/
      line[(leader+2)..-1]
    end

    def is_item_line(line)
      line.start_with? "\s-"
    end

    def is_header_line(line)
      !is_item_line(line) && line.end_with?(":")
    end

    def parse(contents)
      vita = {}
      last_heading = ""
      contents.each_line do |line|
        line = line.chomp.strip
        unless line.empty?
          if (is_header_line(line))
            last_heading = parse_header(line)
          else
            line = parse_item(line)
            items = vita.fetch(last_heading, [])
            items.push line
            vita[last_heading] = items
          end
        end
      end
      vita
    end

  end

end

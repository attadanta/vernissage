# coding: utf-8

module Vernissage

  # Parses the bio and contact files for the website. The scheme of these files
  # is a simple collection of items under headings. Here's an example:
  #
  #   Skills:
  #
  #     - handles earthquake suppression and blocks tsunamis with torso
  #     - battles rattlesnakes single-handedly
  #
  #   Experience:
  #
  #     - >20 years of villain chasing and crime investigation.
  #     - sparring partner of Bruce Wayne.
  class Vita

    # Parses a heading.
    #
    # @param [String] line
    #
    # @return [String]
    def parse_header(line)
      line[0...-1]
    end

    # Parses an item line.
    #
    # @param [String] line
    #
    # @return [String]
    def parse_item(line)
      leader = line =~ /-/
      line[(leader + 2)..-1]
    end

    # Determines if the given line indicates an item. An item is preceded by
    # the '-' character.
    #
    # @param [String] line line of text.
    #
    # @return [Boolean]
    def is_item_line(line)
      line.start_with? "\s-"
    end

    # Determines if the given line indicates a heading. An heading is followed
    # by the ':' character and is not an item line.
    #
    # @param [String] line line of text.
    #
    # @return [Boolean]
    def is_header_line(line)
      !is_item_line(line) && line.end_with?(':')
    end

    # Parses the contents of a text file.
    #
    # @param [String] contents file contents.
    #
    # @return [Hash<String, String>] the parsed file.
    def parse(contents)
      vita = {}

      last_heading = ''
      contents.each_line do |line|
        line = line.chomp.strip
        unless line.empty?
          if is_header_line(line)
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

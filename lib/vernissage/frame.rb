# coding: utf-8

module Vernissage

  class Frame

    attr_accessor :level
    attr_reader   :contents

    def initialize(name, contents, properties={})
      @level = 0
      @name = name
      @contents = contents
      if is_compound?
        @contents.increase_level
      end
      @properties = properties
    end

    def render
      io = StringIO.new
      io << render_opening_tag
      io << render_contents
      io << render_closing_tag
      io.close; io.string
    end

    def render_opening_tag
      io = StringIO.new
      io << "<#{@name}"
      io << " " + render_properties unless @properties.empty?
      io << ">"
      io.close; io.string
    end

    def render_properties
      @properties.map do |pair|
        "#{pair[0].to_s}=\"#{pair[1].to_s}\""
      end.join(" ")
    end

    def render_contents
      if @contents.respond_to? :render
        @contents.render
      else
        @contents
      end
    end

    def render_closing_tag
      "</#{@name}>"
    end

    def is_compound?
      @contents.respond_to? :render
    end

    protected

    def increase_level
      @level = @level + 1
      if is_compound?
        @contents.increase_level
      end
    end

  end

  class ImageFrame < Frame

    def initialize(source, properties={})
      super("img", source, properties)
      @properties = properties.merge src: @contents
    end

    def render_opening_tag
      io = StringIO.new
      io << "<#{@name}"
      io << " " + render_properties unless @properties.empty?
      io.close; io.string
    end

    def render_contents
      ""
    end

    def render_closing_tag
      " />"
    end

  end

end

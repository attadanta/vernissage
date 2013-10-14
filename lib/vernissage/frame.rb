# coding: utf-8
require 'stringio'

module Vernissage

  class Frame

    def initialize(name, contents, properties={})
      @name = name
      @contents = contents
      @properties = properties
    end

    def render
      io = StringIO.new
      io << opening_tag
      io << contents
      io << closing_tag
      io.close; io.string
    end

    def opening_tag
      io = StringIO.new
      io << "<#{@name}"
      io << " " + properties unless properties.empty?
      io << ">"
      io.close; io.string
    end

    def properties
      @properties.map do |pair|
        "#{pair[0].to_s}=\"#{pair[1].to_s}\""
      end.join(" ")
    end

    def contents
      if @contents.respond_to? :render
        @contents.render
      else
        @contents
      end
    end

    def closing_tag
      "</#{@name}>"
    end

  end

  class ImageFrame < Frame

    def initialize(source, properties={})
      super("img", source, properties)
      @properties = properties.merge src: @contents
    end

    def opening_tag
      io = StringIO.new
      io << "<#{@name}"
      io << " " + properties unless properties.empty?
      io.close; io.string
    end

    def contents
      ""
    end

    def closing_tag
      " />"
    end

  end

end

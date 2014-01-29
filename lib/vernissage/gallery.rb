# coding: utf-8
require 'pathname'

module Vernissage

  class Gallery

    include Curator

    attr_reader :path
    attr_reader :name
    attr_reader :exhibits

    def initialize(path)
      @path = path
      @name = path.basename.to_s.capitalize
      @exhibits = []
    end

    def add_exhibit(exhibit)
      @exhibits.push exhibit
    end

    def render(framespec={})
      rendering = StringIO.new
      rendering << <<-END
      <section id="#{@name.downcase}">
        <div class="gallery">
          <h1>#{@name}</h1>
      END
      @exhibits.each do |exhibit|
        rendering << "  " * 5 + exhibit.render(framespec) + "\n"
      end
      rendering << <<-END
        </div>
      </section>
      END
      rendering.string
    end

  end

end

# coding: utf-8

module Vernissage

  class Finissage

    # discovery: a Discovery instance
    # bio: a Pathname instance
    # template: a Pathname instance
    def initialize(discovery, bio, contact, template)
      @curations = discovery.curations
      @bio = Vita.new.parse(bio.read)
      @contact = Vita.new.parse(contact.read)
      @template = template.read
    end

    def galleries
      @curations.map { |curation| curation.to_gallery }
    end

    def exhibitions
      @bio['Exhibitions']
    end

    def languages
      @bio['Languages']
    end

    def education
      @bio['Education']
    end

    def contact
      @contact
    end

    def report
    end

    def render
    end

  end

end

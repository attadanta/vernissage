# coding: utf-8

module Vernissage

  # Assembles the site.
  class Finissage

    # Class constructor.
    #
    # discovery: a Discovery instance
    # bio: a Pathname instance
    # contact: a Pathname instance
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
      @bio.fetch('Exhibitions')
    end

    def languages
      @bio.fetch('Languages')
    end

    def education
      @bio.fetch('Education')
    end

    def contact
      @contact
    end

    def report
    end

    def render
      Haml::Engine.new(@template).render(self)
    end

  end

end

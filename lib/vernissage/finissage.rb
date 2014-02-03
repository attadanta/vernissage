# coding: utf-8

module Vernissage

  # Assembles the site.
  class Finissage

    # Class constructor.
    #
    # @param [Vernissage::Discovery] discovery a discovery instance.
    # @param [Pathname] bio a path to the bio file.
    # @param [Pathname] contact a path to the contact file.
    # @param [Pathname] template a path to the site template.
    def initialize(discovery, bio, contact, template)
      @curations = discovery.curations
      @bio = Vita.new.parse(bio.read)
      @contact = Vita.new.parse(contact.read)
      @template = template.read
    end

    # Compiles the site galleries.
    #
    # @return [Array<Vernissage::Gallery>] a list of galleries as compiled by
    #   the {Vernissage::Discovery}'s {Vernissage::Curation} instance and
    #   sorted by their names.
    def galleries
      @curations.map { |curation| curation.to_gallery }.sort do |a, b|
        a.name <=> b.name
      end
    end

    # Returns the exhibitions section found in the bio.
    #
    # @return [Array<String>] the lines under the `Exhibitions` heading in the
    #   bio file.
    def exhibitions
      @bio.fetch('Exhibitions')
    end

    # Returns the languages section found in the bio.
    #
    # @return [Array<String>] the lines under the `Languages` heading in the
    #   bio file.
    def languages
      @bio.fetch('Languages')
    end

    # Returns the education section found in the bio.
    #
    # @return [Array<String>] the lines under the `Education` heading in the
    #   bio file.
    def education
      @bio.fetch('Education')
    end

    # Returns the parsed contact information.
    #
    # @return [Hash<String, Array<String>>] a hash containing the contact
    #   information, as given by the contact file.
    def contact
      @contact
    end

    def render(webroot=Pathname.new('/'))
      @webroot = webroot
      Haml::Engine.new(@template).render(self)
    end

  end

end

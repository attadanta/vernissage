$:.unshift File.dirname(__FILE__)

require 'pathname'
require 'stringio'

require 'vernissage/frame'
require 'vernissage/curator'
require 'vernissage/image'
require 'vernissage/exhibit'
require 'vernissage/gallery'
require 'vernissage/curation'
require 'vernissage/vita'

# A web gallery processor made for http://plamenmadjarovart.com.
module Vernissage

  class Vernissage

    def initialize(discovery)
      @discovery = discovery
    end

    def galleries
    end

    def exhibitions
    end

    def languages
    end

    def contact
    end

    def report
    end

    def render
    end

  end

end

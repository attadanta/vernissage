$:.unshift File.dirname(__FILE__)

require 'pathname'
require 'stringio'
require 'haml'

require 'vernissage/comparable'
require 'vernissage/curator'
require 'vernissage/discovery'
require 'vernissage/image'
require 'vernissage/exhibit'
require 'vernissage/gallery'
require 'vernissage/curation'
require 'vernissage/vita'
require 'vernissage/report'
require 'vernissage/finissage'

# A web gallery processor made for http://plamenmadjarovart.com.
module Vernissage
end

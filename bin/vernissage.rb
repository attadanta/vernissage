$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'vernissage'

path_to_originals = Pathname.new ARGV[0]
path_to_thumbnails = Pathname.new ARGV[1]
bio = Pathname.new ARGV[2]
contact = Pathname.new ARGV[3]
template = Pathname.new ARGV[4]

discovery = Vernissage::Discovery.new(path_to_originals, path_to_thumbnails)
finissage = Vernissage::Finissage.new(discovery, bio, contact, template)

puts finissage.render

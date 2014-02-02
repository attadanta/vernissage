$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'vernissage'

path_to_originals = Pathname.new ARGV[0]
path_to_thumbnails = Pathname.new ARGV[1]

discovery = Vernissage::Discovery.new(path_to_originals, path_to_thumbnails)
curations = discovery.curations

report = Vernissage::Report.new(curations)

puts report.generate

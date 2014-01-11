require 'pathname'
require 'builder'
require 'mg2en'
require 'libxml'
include LibXML

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# configure libxml-ruby
XML.default_load_external_dtd = true

# create a XML catalog for libxml to prevent hitting the network for external
# entity resolution
ENV['XML_CATALOG_FILES'] ||= File.expand_path('../../tmp/catalog.xml',
                                              __FILE__)
dtds = File.expand_path('../dtds/', __FILE__)
catalog_dir = Pathname.new(ENV['XML_CATALOG_FILES']).dirname
Dir.mkdir(catalog_dir) unless Dir.exists?(catalog_dir)

unless File.exists?(ENV['XML_CATALOG_FILES'])
  File.open(ENV['XML_CATALOG_FILES'], 'w') do |f|
    # rubocop:disable LineLength
    f << '<?xml version="1.0"?>'
    f << '<!DOCTYPE catalog PUBLIC "-//OASIS//DTD Entity Resolution XML Catalog V1.0//EN"'
    f << ' "http://www.oasis-open.org/committees/entity/release/1.0/catalog.dtd">'
    f << '<catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog">'
    f << "<rewriteSystem systemIdStartString=\"http://www.w3.org/TR/xhtml1/DTD/\" rewritePrefix=\"file://#{dtds}/\"/>"
    f << '</catalog>'
    # rubocop:enable LineLength
  end
end

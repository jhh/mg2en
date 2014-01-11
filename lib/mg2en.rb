require 'mg2en/parser'
require 'mg2en/generator'
require 'mg2en/recipe'
require 'mg2en/options'
require 'mg2en/version'

# Configuration for library
module Mg2en
  Haml::Options.defaults[:format] = :xhtml
end

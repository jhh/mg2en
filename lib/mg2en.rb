require 'mg2en/parser'
require 'mg2en/generator'
require 'mg2en/recipe'
require 'mg2en/ingredient'
require 'mg2en/direction'
require 'mg2en/options'

# Configuration for library
module Mg2en
  Haml::Options.defaults[:format] = :xhtml
end

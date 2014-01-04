require "mg2en/parser"
require "mg2en/generator"
require "mg2en/recipe"
require "mg2en/ingredient"
require "mg2en/direction"

module Mg2en
  VERSION = "0.0.1"
  Haml::Options.defaults[:format] = :xhtml
end

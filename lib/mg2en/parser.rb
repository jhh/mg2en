require 'mg2en/recipe'
require 'plist'

module Mg2en
  # Parse a MacGourmet 3 Plist export file into array of recipe objects.
  class Parser
    attr_reader :recipes
    def initialize(filename_or_xml)
      recipe_input = Plist.parse_xml(filename_or_xml)
      fail ArgumentError, 'Unable to parse input' unless recipe_input

      @recipes = []
      recipe_input.each do |r|
        recipe = Mg2en::Recipe.new(r)
        @recipes.push recipe
      end
    end
  end
end

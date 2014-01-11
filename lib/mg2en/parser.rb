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

        r['INGREDIENTS_TREE'].each do |i|
          ingredient = Mg2en::Ingredient.new(i)
          recipe.ingredients.push ingredient
        end

        r['DIRECTIONS_LIST'].each do |d|
          direction = Mg2en::Direction.new(d)
          recipe.directions.push direction
        end

        if r['NOTES_LIST']
          r['NOTES_LIST'].each do |n|
            recipe.notes.push n['NOTE_TEXT']
          end
        end

        if r['CATEGORIES']
          r['CATEGORIES'].each do |c|
            recipe.tags.push c['NAME']
          end
        end

        @recipes.push recipe
      end
    end
  end
end

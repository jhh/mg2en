require 'plist'

module Mg2en

  def Mg2en::parse_xml(filename_or_xml)
    recipe_input = Plist::parse_xml(filename_or_xml)
    raise ArgumentError unless recipe_input

    recipe_list = Array.new

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

      r['NOTES_LIST'].each do |n|
        recipe.notes.push n['NOTE_TEXT']
      end

      recipe_list.push recipe
    end
    recipe_list
  end

end
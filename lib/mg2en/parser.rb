require 'plist'

module Mg2en

  def Mg2en::parse_xml(filename_or_xml)
    recipe_input = Plist::parse_xml(filename_or_xml)
    recipe_list = Array.new

    recipe_input.each do |r|
      recipe = Mg2en::Recipe.new
      recipe.name    = r['NAME']
      recipe.summary = r['SUMMARY']
      recipe.note    = r['NOTE']
      recipe.source  = r['SOURCE']
      recipe.url     = r['PUBLICATION_PAGE']

      r['INGREDIENTS_TREE'].each do |i|
        ingredient = Mg2en::Ingredient.new
        ingredient.quantity    = i['QUANTITY']
        ingredient.measurement = i['MEASUREMENT']
        ingredient.description = i['DESCRIPTION']
        ingredient.direction   = i['DIRECTION']
        recipe.ingredients.push ingredient
      end

      r['DIRECTIONS_LIST'].each do |d|
        direction = Mg2en::Direction.new
        direction.description    = d['DIRECTION_TEXT']
        direction.label          = d['LABEL_TEXT']
        direction.is_highlighted = d['IS_HIGHLIGHTED']
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
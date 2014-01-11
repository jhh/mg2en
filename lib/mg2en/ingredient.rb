module Mg2en
  # This class holds an ingredient.
  class Ingredient
    attr_reader :measurement, :quantity, :description, :direction, :group,
                :ingredients, :link
    alias_method :group?, :group
    alias_method :link?, :link

    def initialize(i)
      if i.key?('DESCRIPTION')
        @group       = false
        @quantity    = i['QUANTITY']
        @measurement = i['MEASUREMENT']
        @description = i['DESCRIPTION']
        @direction   = i['DIRECTION']
        @link        = i['INCLUDED_RECIPE_ID'] > 0
      elsif i.key?('DIVIDER_INGREDIENT')
        @group       = true
        @description = i['DIVIDER_INGREDIENT']['DESCRIPTION']
        @ingredients = []
        ingts = i['INGREDIENTS']
        ingts.each do |ing|
          ingredient = Mg2en::Ingredient.new(ing)
          @ingredients.push ingredient
        end
      else
        fail 'Did not recognize input'
      end
    end

    def to_s
      return @description if self.group?
      output = ''
      output << @quantity unless @quantity.empty?
      output << without_quantity
    end

    def without_quantity
      output = ''
      output << ' ' << @measurement unless @measurement.empty?
      output << ' ' << @description
      output << ', ' << @direction unless @direction.empty?
      output
    end
  end
end

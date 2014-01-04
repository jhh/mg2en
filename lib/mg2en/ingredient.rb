module Mg2en

  class Ingredient
    attr_reader :measurement, :quantity, :description, :direction, :group, :ingredients
    alias_method :group?, :group

    def initialize(i)
      if i.has_key?('DESCRIPTION')
        @quantity    = i['QUANTITY']
        @measurement = i['MEASUREMENT']
        @description = i['DESCRIPTION']
        @direction   = i['DIRECTION']
        @group       = false
      elsif i.has_key?('DIVIDER_INGREDIENT')
        @group       = true
        @description = i['DIVIDER_INGREDIENT']['DESCRIPTION']
        @ingredients = Array.new
        ingts = i['INGREDIENTS']
        ingts.each do |ing|
          ingredient = Mg2en::Ingredient.new(ing)
          @ingredients.push ingredient
        end
      else
        raise RuntimeError
      end
    end

    def to_s
      return @description if self.group?
      output = ""
      output << @quantity unless @quantity.empty?
      output << " " << @measurement unless @measurement.empty?
      output << " " << @description
      output << ", " << @direction unless @direction.empty?
      output
    end

  end
end

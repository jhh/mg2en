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
        @group       = i['IS_DIVIDER']
      elsif i.has_key?('DIVIDER_INGREDIENT')
        @group       = true
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

    def enml
      "#{self.quantity} #{self.measurement} #{self.description}, #{self.direction}"
    end
  end
end

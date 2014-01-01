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

    def enml(xm)
      if self.group?
        xm.li {
          xm << @description
          xm.ul {
            nested_output = ""
            b = Builder::XmlMarkup.new(target:nested_output)
            @ingredients.each do |i|
              i.enml(b)
            end
            xm << nested_output
          }
        }
      else
        output = ""
        output << @quantity unless @quantity.empty?
        output << " " << @measurement unless @measurement.empty?
        output << " " << @description
        output << ", " << @direction unless @direction.empty?
        xm.li(output)
      end
    end
  end
end

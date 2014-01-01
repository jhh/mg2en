module Mg2en

  class Ingredient
    attr_reader :measurement, :quantity, :description, :direction

    def initialize(i)
      @quantity    = i['QUANTITY']
      @measurement = i['MEASUREMENT']
      @description = i['DESCRIPTION']
      @direction   = i['DIRECTION']
    end

    def enml
      "#{self.quantity} #{self.measurement} #{self.description}, #{self.direction}"
    end
  end

end

module Mg2en

  class Ingredient
    attr_accessor :measurement, :quantity, :description, :direction

    def enml
      "#{self.quantity} #{self.measurement} #{self.description}, #{self.direction}"
    end
  end

end

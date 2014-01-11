module Mg2en
  # This class holds a recipe direction step.
  class Direction
    attr_reader :description, :label, :highlighted
    alias_method :highlighted?, :highlighted

    def initialize(d)
      @description = d['DIRECTION_TEXT']
      @label       = d['LABEL_TEXT']
      @highlighted = d['IS_HIGHLIGHTED']
    end

    def to_s
      "#{label} #{description} #{highlighted}"
    end
  end
end

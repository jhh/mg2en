module Mg2en

  class Direction
    attr_reader :description, :label, :highlighted
    alias_method :highlighted?, :highlighted

    def initialize(d)
      @description = d['DIRECTION_TEXT']
      @label       = d['LABEL_TEXT']
      @highlighted = d['IS_HIGHLIGHTED']
    end

    def enml(xm)
      xm.li {
        xm.strong(@label) unless @label.empty?
        xm << " " << @description
      }
    end
  end

end
require 'haml'
require 'digest'

module Mg2en

  class Recipe
    attr_reader :name, :summary, :note, :source, :url, :image
    attr_reader :ingredients, :directions, :notes

    def initialize(r)
      @ingredients = Array.new
      @directions  = Array.new
      @notes       = Array.new
      @name        = r['NAME']
      @summary     = r['SUMMARY']
      @note        = r['NOTE']
      @source      = r['SOURCE']
      @url         = r['PUBLICATION_PAGE']
      @image       = r['IMAGE'].read if r['IMAGE']
    end

    def enml
      template = File.expand_path("../../../templates/default.haml", __FILE__)
      engine = Haml::Engine.new(File.open(template).read)
      engine.render(self)
    end

  end
end

require 'mg2en/ingredient'
require 'mg2en/direction'
require 'haml'
require 'digest'
require 'image_science'
require 'tempfile'
require 'uri'
require 'active_support/core_ext/object/blank'

module Mg2en
  # This class holds a recipe.
  class Recipe
    attr_reader :name, :summary, :note, :source, :url, :image
    attr_reader :ingredients, :directions, :notes, :tags, :cuisine

    def initialize(r)
      @name        = r['NAME']
      @summary     = r['SUMMARY']
      @note        = r['NOTE']
      @source      = r['SOURCE']
      @url         = check_url(r['PUBLICATION_PAGE'])
      @yield       = r['YIELD']
      @servings    = r['SERVINGS']
      scale_image(r['IMAGE'].read) if r['IMAGE']

      @ingredients = []
      r['INGREDIENTS_TREE'].each do |i|
        ingredient = Mg2en::Ingredient.new(i)
        @ingredients.push ingredient
      end

      @directions  = []
      r['DIRECTIONS_LIST'].each do |d|
        direction = Mg2en::Direction.new(d)
        @directions.push direction
      end

      @notes       = []
      r['NOTES_LIST'] && r['NOTES_LIST'].each { |n| @notes.push n['NOTE_TEXT'] }

      @tags        = []
      r['CATEGORIES'] && r['CATEGORIES'].each { |c| @tags.push c['NAME'] }

      @cuisine     = []
      r['CUISINE'] && r['CUISINE'].each { |c| @cuisine.push c['NAME']}
    end

    def enml
      template_file = Mg2en::Options.defaults[:template] + '.haml'
      template = File.expand_path("../../../templates/#{template_file}",
                                  __FILE__)
      engine = Haml::Engine.new(File.open(template).read)
      engine.render(self)
    end

    def scale_image(image)
      file = Tempfile.new(['thumb', '.jpg'])
      begin
        ImageScience.with_image_from_memory(image) do |i|
          i.cropped_thumbnail(Mg2en::Options.defaults[:image_size]) do |thumb|
            thumb.save(file.path)
          end
        end
        @image = file.read
      ensure
        file.close
        file.unlink
      end
    end

    def check_url(url)
      uri = URI.parse(url)
      if uri.scheme.eql?('http') || uri.scheme.eql?('https')
        return uri.to_s
      else
        return nil
      end
    rescue
      return nil
    end
  end
end

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
    attr_reader :ingredients, :directions, :notes, :tags

    def initialize(r)
      @ingredients = []
      @directions  = []
      @notes       = []
      @tags        = []
      @name        = r['NAME']
      @summary     = r['SUMMARY']
      @note        = r['NOTE']
      @source      = r['SOURCE']
      @url         = check_url(r['PUBLICATION_PAGE'])
      @yield       = r['YIELD']
      @servings    = r['SERVINGS']
      scale_image(r['IMAGE'].read) if r['IMAGE']
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

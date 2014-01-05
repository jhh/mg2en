require 'haml'
require 'digest'
require 'image_science'
require 'tempfile'

module Mg2en

  class Recipe
    attr_reader :name, :summary, :note, :source, :url, :image
    attr_reader :ingredients, :directions, :notes, :tags

    def initialize(r)
      @ingredients = Array.new
      @directions  = Array.new
      @notes       = Array.new
      @tags        = Array.new
      @name        = r['NAME']
      @summary     = r['SUMMARY']
      @note        = r['NOTE']
      @source      = r['SOURCE']
      @url         = r['PUBLICATION_PAGE']
      scale_image(r['IMAGE'].read) if r['IMAGE']
    end

    def enml
      template_file = Mg2en::Options.defaults[:template] + '.haml'
      template = File.expand_path("../../../templates/#{template_file}", __FILE__)
      engine = Haml::Engine.new(File.open(template).read)
      engine.render(self)
    end

    def scale_image(image)
      file = Tempfile.new(['thumb', '.jpg'])
      begin
        ImageScience.with_image_from_memory(image) do |i|
          i.cropped_thumbnail(Mg2en::Options.defaults[:image_size]) { |thumb| thumb.save(file.path) }
        end
        @image = file.read
      ensure
        file.close
        file.unlink
      end
    end

  end
end

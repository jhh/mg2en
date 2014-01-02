require 'builder'
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
      output = ""
      xm = Builder::XmlMarkup.new(target:output)
      xm.instruct! :xml, version: "1.0", encoding: "UTF-8"
      xm.declare! :DOCTYPE, :"en-note", :SYSTEM, "http://xml.evernote.com/pub/enml2.dtd"
      xm.tag!("en-note") {
        xm.h1(self.name)
        xm.p(self.summary)
        xm.h2("INGREDIENTS")
        xm.ul {
          self.ingredients.each do |i|
            i.enml(xm)
          end
        }
        xm.h2("DIRECTIONS")
        xm.ol {
          self.directions.each do |d|
            d.enml(xm)
          end
        }
        xm.p("NOTES")
        xm.ul {
          self.notes.each do |n|
            xm.li(n)
          end
        }
        xm.tag!("en-media", type: "image/jpeg", hash: Digest::MD5.hexdigest(@image)) if @image
      }
      output
    end

  end

end

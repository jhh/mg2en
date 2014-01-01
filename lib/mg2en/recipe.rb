require 'builder'
module Mg2en

  class Recipe
    attr_reader :name, :summary, :note, :source, :url
    attr_reader :ingredients, :directions, :notes

    def initialize(r)
      @ingredients = Array.new
      @directions  = Array.new
      @notes       = Array.new
      @name    = r['NAME']
      @summary = r['SUMMARY']
      @note    = r['NOTE']
      @source  = r['SOURCE']
      @url     = r['PUBLICATION_PAGE']
    end

    def enml
      output = ""
      xm = Builder::XmlMarkup.new(target:output)
      xm.instruct! :xml, version:"1.0", encoding:"UTF-8"
      xm.declare! :DOCTYPE, :"en-note", :SYSTEM, "http://xml.evernote.com/pub/enml2.dtd"
      xm.tag!("en-note") {
        xm.h1(self.name)
        xm.p(self.summary)
        xm.h2("INGREDIENTS")
        xm.ul {
          self.ingredients.each do |i|
            xm.li(i.enml)
          end
        }
        xm.h2("DIRECTIONS")
        xm.ol {
          self.directions.each do |d|
            xm.li(d.description)
          end
        }
        xm.p("NOTES")
        xm.ul {
          self.notes.each do |n|
            xm.li(n)
          end
        }
      }
      output
    end

  end

end

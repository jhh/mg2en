require 'builder'
require 'base64'

# Writes out an array of recipe objects into ENEX file.
module Mg2en
  def self.emit_enex(recipe_list, destination = nil)
    xm = open_destination(destination)
    xm.instruct! :xml, version: '1.0', encoding: 'UTF-8'
    xm.declare! :DOCTYPE, :"en-export", :SYSTEM,
                'http://xml.evernote.com/pub/evernote-export3.dtd'
    xm.tag!(:'en-export',
            :'export-date' => Time.new.strftime('%Y%m%dT%H%M%S%z'),
            application: 'mg2en',
            version: Mg2en::VERSION) do
      recipe_list.each do |recipe|
        xm.note do
          xm.title(recipe.name)
          xm.content { xm.cdata!(recipe.enml) }
          recipe.tags.each do |t|
            xm.tag(t)
          end
          xm.tag!(:'note-attributes') do
            xm.source(recipe.source) if recipe.source
            xm.tag!(:'source-url') { xm.text! recipe.url } if recipe.url
          end
          if recipe.image
            xm.resource do
              xm.data(encoding: 'base64') do |d|
                d << Base64.encode64(recipe.image)
              end
              xm.mime('image/jpeg')
            end
          end
        end
      end
    end
    xm.target!.close if destination
  end

  def self.open_destination(destination)
    if destination
      df = open(destination, 'w')
      return Builder::XmlMarkup.new(target: df)
    else
      return Builder::XmlMarkup.new(target: STDOUT)
    end
  end
end

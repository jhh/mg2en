require 'base64'
module Mg2en

  def Mg2en::emit_enex(recipe_list, destination=nil)
    if destination
      df = open(destination, "w")
      xm = Builder::XmlMarkup.new(target:df)
    else
      xm = Builder::XmlMarkup.new(target:STDOUT)
    end
    xm.instruct! :xml, version:"1.0", encoding:"UTF-8"
    xm.declare! :DOCTYPE, :"en-export", :SYSTEM, "http://xml.evernote.com/pub/evernote-export3.dtd"
    xm.tag!(:"en-export", :"export-date" => Time.new.strftime("%Y%m%dT%H%M%S%z"),
    application:"mg2en", version:Mg2en::VERSION) {
      recipe_list.each do |recipe|
        xm.note {
          xm.title(recipe.name)
          xm.content {xm.cdata!(recipe.enml)}
          xm.tag!(:"note-attributes") {
            xm.source(recipe.source)
            xm.tag!(:"source-url") { xm.text! recipe.url }
          }
          if recipe.image
            xm.resource {
              xm.data(encoding: "base64") { |d| d << Base64.encode64(recipe.image)}
              xm.mime("image/jpeg")
            }
          end
        }
      end
    }
    df.close if destination
  end

end

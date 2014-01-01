module Mg2en

  def Mg2en::emit_enml(recipe_list)
    # output = ""
    xm = Builder::XmlMarkup.new(target:STDOUT)
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
        }
      end
    }
  end

end
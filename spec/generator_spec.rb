require 'spec_helper'

describe Mg2en, "generator" do
  let(:recipes) { Mg2en::parse_xml('spec/fixtures/1.mgourmet3') }
  let(:output_file) { 'tmp/fixture.enex' }

  it "passes validation" do
    XML.default_load_external_dtd = false
    Mg2en::emit_enex(recipes, output_file)
    dtd = XML::Dtd.new(File.read("spec/dtds/evernote-export3.dtd"))
    doc = XML::Document.file(output_file)
    expect(doc.validate(dtd)).to be true
  end

end

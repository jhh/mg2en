require 'spec_helper'

describe Mg2en, 'generator' do
  let(:parser) { Mg2en::Parser.new('spec/fixtures/1.mgourmet3') }
  let(:output_file) { 'tmp/fixture.enex' }
  let(:generator) { Mg2en::Generator.new(parser.recipes) }

  it 'passes validation' do
    XML.default_load_external_dtd = false
    generator.write(output_file)
    dtd = XML::Dtd.new(File.read('spec/dtds/evernote-export3.dtd'))
    doc = XML::Document.file(output_file)
    expect(doc.validate(dtd)).to be true
  end

end

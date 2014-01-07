require 'spec_helper'

describe Mg2en::Recipe do

  let(:recipes) { Mg2en::parse_xml(File.dirname(__FILE__) + '/fixtures/1.mgourmet3') }
  let(:bad_url) { Mg2en::parse_xml(File.dirname(__FILE__) + '/fixtures/2.mgourmet3') }

  it "parses recipe" do
    r = recipes[1]
    expect(r.name).to eql("Recipe B")
    expect(r.summary).to eql("This is the introduction/summary.")
    expect(r.note).to eql("These are the notes.")
    expect(r.source).to eql("Test Fixture B")
    expect(r.url).to eql("http://example.com/B")
  end

  it "parses notes" do
    n = recipes[1].notes
    expect(n[1]).to eql("This is a chef note.")
  end

  it "ignores bad source URL" do
    expect(bad_url[0].url).to be nil
  end

  it "returns empty string for empty source" do
    expect(bad_url[0].source).to be_empty
  end

  context "when validating templates" do
    dtd = XML::Dtd.new(File.read("spec/dtds/enml2.dtd"))
    ['default'].each do |template|
      it "#{template} template passes" do
        Mg2en::Options.defaults[:template] = template
        recipes.each do |recipe|
          doc = XML::Document.string(recipe.enml)
          expect(doc.validate(dtd)).to be true
        end
      end
    end
  end

end

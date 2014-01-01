require 'spec_helper'

describe Mg2en, "parser" do

  context "with invalid input" do
    it "should error on non-existing file" do
      expect {
        Mg2en::parse_xml(File.dirname(__FILE__) + '/fixtures/missing.mgourmet3')
      }.to raise_error(ArgumentError)
    end

    it "should error on malformed input" do
      expect {
        Mg2en::parse_xml('<plist version="1.0"><foo/></plist>')
      }.to raise_error(RuntimeError)
    end
  end

  context "with valid input" do
    let(:recipes) { Mg2en::parse_xml(File.dirname(__FILE__) + '/fixtures/1.mgourmet3') }

    it "has corrent number of recipes" do
      expect(recipes.size).to eq(2)
    end

    it "parses recipe" do
      r = recipes[0]
      expect(r.name).to eql("Recipe A")
      expect(r.summary).to eql("This is the introduction/summary.")
      expect(r.note).to eql("This is a cooking note.")
      expect(r.source).to eql("Test Fixture A")
      expect(r.url).to eql("http://example.com/A")
    end

    it "parses top-level ingredients" do
      i = recipes[0].ingredients
      expect(i[0].measurement).to eql("clove")
      expect(i[0].quantity).to eql("1")
      expect(i[0].description).to eql("Garlic")
      expect(i[0].direction).to eql("")
      expect(i[1].direction).to eql("chopped")
    end

    it "parses directions" do
      d = recipes[0].directions
      expect(d[0].description).to eql("Prepare the ingredients.")
      expect(d[0].label).to eql("Prepare")
      expect(d[0].highlighted?).to be false
      expect(d[1].highlighted?).to be true
    end

    it "parses notes" do
      n = recipes[1].notes
      expect(n[1]).to eql("This is a chef note.")
    end
  end

end

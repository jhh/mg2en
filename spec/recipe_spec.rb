require 'spec_helper'

describe Mg2en::Recipe do

  context "with valid input" do
    let(:recipes) { Mg2en::parse_xml(File.dirname(__FILE__) + '/fixtures/1.mgourmet3') }

    it "parses recipe" do
      r = recipes[0]
      expect(r.name).to eql("Recipe A")
      expect(r.summary).to eql("This is the introduction/summary.")
      expect(r.note).to eql("This is a cooking note.")
      expect(r.source).to eql("Test Fixture A")
      expect(r.url).to eql("http://example.com/A")
    end

    it "parses notes" do
      n = recipes[1].notes
      expect(n[1]).to eql("This is a chef note.")
    end
  end
end

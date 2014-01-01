require 'spec_helper'

describe Mg2en::Ingredient do

  context "with valid input" do
    let(:recipes) { Mg2en::parse_xml(File.dirname(__FILE__) + '/fixtures/1.mgourmet3') }

    it "parses top-level ingredients" do
      i = recipes[0].ingredients
      expect(i[0].measurement).to eql("clove")
      expect(i[0].quantity).to eql("1")
      expect(i[0].description).to eql("Garlic")
      expect(i[0].direction).to eql("")
      expect(i[1].direction).to eql("chopped")
    end
  end
end

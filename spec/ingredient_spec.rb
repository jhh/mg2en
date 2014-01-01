require 'spec_helper'

describe Mg2en::Ingredient do

  let(:recipes) { Mg2en::parse_xml(File.dirname(__FILE__) + '/fixtures/1.mgourmet3') }

  it "parses ingredients" do
    i = recipes[0].ingredients
    expect(i.size).to eql(2)
    expect(i[0].measurement).to eql("clove")
    expect(i[0].quantity).to eql("1")
    expect(i[0].description).to eql("Garlic")
    expect(i[0].direction).to eql("")
    expect(i[1].direction).to eql("chopped & chopped")
    expect(i[0].group?).to be false
  end

  it "parses ingredient groups" do
    i = recipes[1].ingredients
    expect(i.size).to eql(5)
    expect(i[0].group?).to be false
    ig = i[2]
    expect(ig.group?).to be true
    expect(ig.description).to eql("Group 1")
    expect(ig.ingredients.size).to eql(2)
    expect(ig.ingredients[0].description).to eql("saffron")
    expect(ig.ingredients[1].description).to eql("salt")
  end

  context "when generating ENML" do
    output = ""
    let(:xm) {Builder::XmlMarkup.new(target:output)}
    before(:each) {output = ""}

    it "outputs ingredient" do
      i = recipes[1].ingredients
      i[0].enml(xm)
      expect(output).to eql("<li>1 clove Garlic</li>")
    end

    it "handles entities" do
      i = recipes[0].ingredients
      i[1].enml(xm)
      expect(output).to eql("<li>1 pound Chicken, chopped &amp; chopped</li>")
    end

    it "outputs ingredient group" do
      i = recipes[1].ingredients
      i[2].enml(xm)
      expect(output).to eql("<li>Group 1<ul><li>3 threads saffron</li><li>2 teaspoons salt</li></ul></li>")
    end
  end
end

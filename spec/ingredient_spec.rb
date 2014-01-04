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

  it "outputs ingredient" do
    i = recipes[0].ingredients
    expect(i[1].to_s).to eql("1 pound Chicken, chopped & chopped")
  end
end

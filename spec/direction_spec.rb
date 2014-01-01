require 'spec_helper'

describe Mg2en::Direction do

  context "with valid input" do
    let(:recipes) { Mg2en::parse_xml(File.dirname(__FILE__) + '/fixtures/1.mgourmet3') }

    it "parses directions" do
      d = recipes[0].directions
      expect(d[0].description).to eql("Prepare the ingredients.")
      expect(d[0].label).to eql("Prepare")
      expect(d[0].highlighted?).to be false
      expect(d[1].highlighted?).to be true
    end
  end

  context "when generating ENML" do
    let(:recipes) { Mg2en::parse_xml(File.dirname(__FILE__) + '/fixtures/1.mgourmet3') }
    output = ""
    let(:xm) {Builder::XmlMarkup.new(target:output)}
    before(:each) {output = ""}

    it "outputs direction" do
      d = recipes[1].directions
      d[0].enml(xm)
      expect(output).to eql("<li><strong>Prepare</strong> Prepare the ingredients.</li>")
    end
  end

end

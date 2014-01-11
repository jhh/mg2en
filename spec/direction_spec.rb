require 'spec_helper'

describe Mg2en::Direction do

  context 'with valid input' do
    let(:parser) do
      Mg2en::Parser.new(File.dirname(__FILE__) + '/fixtures/1.mgourmet3')
    end

    it 'parses directions' do
      d = parser.recipes[0].directions
      expect(d[0].description).to eql('Prepare the ingredients.')
      expect(d[0].label).to eql('Prepare')
      expect(d[0].highlighted?).to be false
      expect(d[1].highlighted?).to be true
    end

    it 'outputs direction' do
      d = parser.recipes[1].directions
      expect(d[0].to_s).to eql('Prepare Prepare the ingredients. false')
    end
  end
end

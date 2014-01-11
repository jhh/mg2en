require 'spec_helper'

describe Mg2en, 'parser' do

  context 'with invalid input' do
    it 'should error on non-existing file' do
      expect do
        Mg2en.parse_xml(File.dirname(__FILE__) +
        '/fixtures/missing.mgourmet3')
      end.to raise_error(ArgumentError)
    end

    it 'should error on malformed input' do
      expect do
        Mg2en.parse_xml('<plist version="1.0"><foo/></plist>')
      end.to raise_error(RuntimeError)
    end
  end

  context 'with valid input' do
    let(:recipes) do
      Mg2en.parse_xml(File.dirname(__FILE__) + '/fixtures/1.mgourmet3')
    end

    it 'has corrent number of recipes' do
      expect(recipes.size).to eq(2)
    end
  end
end

require 'spec_helper'

RSpec.describe Marketplace::Product do
  subject { described_class.new('001', 'Example Product', BigDecimal('3.72')) }

  describe '#id' do
    it 'returns the product id' do
      expect(subject.id).to eq('001')
    end
  end

  describe '#name' do
    it 'returns the product name' do
      expect(subject.name).to eq('Example Product')
    end
  end

  describe '#price' do
    it 'returns the product price' do
      expect(subject.price).to eq(BigDecimal('3.72'))
    end
  end
end

require 'spec_helper'

RSpec.describe Marketplace::Promotion::CartTotalAdjustment do
  let(:cart) { Marketplace::Cart.new }

  subject(:promotion) do
    described_class.new(
      value:    BigDecimal(60),
      discount: Rational('1/10')
    )
  end

  describe '#applicable?' do
    context 'when cart total is less than 60' do
      before { allow(cart).to receive(:total).and_return(BigDecimal(45)) }
      it 'will return false' do
        expect(subject.applicable?(cart)).to eq(false)
      end
    end

    context 'when cart total is more than 60' do
      before { allow(cart).to receive(:total).and_return(BigDecimal(75)) }
      it 'will return true' do
        expect(subject.applicable?(cart)).to eq(true)
      end
    end

    context 'when cart total is exactly 60' do
      before { allow(cart).to receive(:total).and_return(BigDecimal(60)) }
      it 'will return true' do
        expect(subject.applicable?(cart)).to eq(true)
      end
    end
  end

  describe '#adjustment' do
    before { allow(cart).to receive(:total).and_return(BigDecimal(150)) }
    it 'returns the necessary monetary change for the cart' do
      expect(subject.adjustment(cart)).to eq(BigDecimal(-15))
    end
  end
end

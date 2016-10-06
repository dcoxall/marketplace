require 'spec_helper'

RSpec.describe Marketplace::Promotion::ProductPriceAdjustment do
  let(:cart) { Marketplace::Cart.new }
  let(:product) { double(:product, id: '001', price: BigDecimal(8)) }

  subject(:promotion) do
    described_class.new(
      product_id:       product.id,
      trigger_quantity: 2,
      value:            BigDecimal('5.50')
    )
  end

  describe '#applicable?' do
    context 'when cart includes 1 product with matching id' do
      before { cart.add(product, 1) }
      it 'will return false' do
        expect(subject.applicable?(cart, cart.total)).to eq(false)
      end
    end

    context 'when cart includes 2 products with matching id' do
      before { cart.add(product, 2) }
      it 'will return true' do
        expect(subject.applicable?(cart, cart.total)).to eq(true)
      end
    end

    context 'when cart includes several products with matching id' do
      before { cart.add(product, 3) }
      it 'will return true' do
        expect(subject.applicable?(cart, cart.total)).to eq(true)
      end
    end

    context 'when cart includes no products with matching id' do
      let(:product_b) { double(:product, id: '002', price: BigDecimal('3.72')) }
      before { cart.add(product_b, 2) }
      it 'will return true' do
        expect(subject.applicable?(cart, cart.total)).to eq(false)
      end
    end
  end

  describe '#adjustment' do
    # imagine the cart contains many more items
    before { allow(cart).to receive(:total).and_return(BigDecimal(150)) }

    context 'with 2 matching products' do
      before { cart.add(product, 2) }
      it 'returns an adjustment of ((2*price)-(2*value))' do
        expect(subject.adjustment(cart, cart.total)).to eq(BigDecimal(-5))
      end
    end

    context 'with many matching products' do
      before { cart.add(product, 5) }
      it 'returns an adjustment of ((n*price)-(n*value))' do
        expect(subject.adjustment(cart, cart.total)).to eq(BigDecimal('-12.5'))
      end
    end
  end
end

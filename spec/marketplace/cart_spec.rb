require 'spec_helper'

RSpec.describe Marketplace::Cart do
  describe 'adding an item' do
    context 'only 1' do
      it 'increments the cart item count' do
        expect { subject.add(double(:product, id: '001'), 1) }
          .to change(subject, :count).by(1)
      end
    end

    context 'amending quantity' do
      let(:product) { double(:product, id: '001') }
      before { subject.add(product, 2) }

      it 'adjusts the cart item count' do
        expect { subject.add(product, -1) }
          .to change(subject, :count).from(2).to(1)
      end
    end

    context 'multiple' do
      it 'increments the cart item count' do
        expect { subject.add(double(:product, id: '001'), 3) }
          .to change(subject, :count).by(3)
      end
    end
  end

  describe '#total' do
    context 'with multiple products' do
      let(:product_a) { double(:product, id: '001', price: BigDecimal('3.47')) }
      let(:product_b) { double(:product, id: '002', price: BigDecimal('18.95')) }

      before do
        subject.add(product_a, 2)
        subject.add(product_b, 1)
      end

      it 'calculates the non promotional value of the cart' do
        expect(subject.total).to eq(BigDecimal('25.89'))
      end
    end

    context 'with no products' do
      it 'returns 0' do
        expect(subject.total).to be_zero
      end
    end
  end

  describe '#quantity_of' do
    let(:product_a) { double(:product, id: '001', price: BigDecimal('3.47')) }
    let(:product_b) { double(:product, id: '002', price: BigDecimal('18.95')) }

    before do
      subject.add(product_a, 3)
      subject.add(product_b, 1)
    end

    it 'returns the quantity for a given product in the cart' do
      expect(subject.quantity_of(product_a.id)).to eq(3)
      expect(subject.quantity_of(product_b.id)).to eq(1)
    end
  end

  describe '#price_of' do
    let(:product_a) { double(:product, id: '001', price: BigDecimal('3.47')) }
    let(:product_b) { double(:product, id: '002', price: BigDecimal('18.95')) }

    before do
      subject.add(product_a, 1)
      subject.add(product_b, 1)
    end

    it 'returns the price for a given product in the cart' do
      expect(subject.price_of(product_a.id)).to eq(product_a.price)
      expect(subject.price_of(product_b.id)).to eq(product_b.price)
    end
  end
end

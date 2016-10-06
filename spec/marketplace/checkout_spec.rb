require 'spec_helper'

RSpec.describe Marketplace::Checkout do
  let(:promotion_a) do
    Marketplace::Promotion::ProductPriceAdjustment.new(
      product_id:       '001',
      value:            BigDecimal('8.50'),
      trigger_quantity: 2
    )
  end

  let(:promotion_b) do
    Marketplace::Promotion::CartTotalAdjustment.new(
      value:    BigDecimal('60.00'),
      discount: Rational('1/10')
    )
  end

  let(:product_a) { Marketplace::Product.new('001', 'Lavender heart', BigDecimal('9.25')) }
  let(:product_b) { Marketplace::Product.new('002', 'Personalised cufflinks', BigDecimal('45.00')) }
  let(:product_c) { Marketplace::Product.new('003', 'Kids T-shirt', BigDecimal('19.95')) }

  subject { described_class.new([promotion_a, promotion_b]) }

  describe '#total' do
    context 'with 001, 002, 003' do
      before do
        subject.scan(product_a)
        subject.scan(product_b)
        subject.scan(product_c)
      end
      it 'returns 66.78' do
        expect(subject.total).to eq(BigDecimal('66.78'))
      end
    end

    context 'with 001, 003, 001' do
      before do
        subject.scan(product_a)
        subject.scan(product_c)
        subject.scan(product_a)
      end
      it 'returns 36.95' do
        expect(subject.total).to eq(BigDecimal('36.95'))
      end
    end
    context 'with 001, 002, 001, 003' do
      before do
        subject.scan(product_a)
        subject.scan(product_b)
        subject.scan(product_a)
        subject.scan(product_c)
      end
      it 'returns 73.76' do
        expect(subject.total).to eq(BigDecimal('73.76'))
      end
    end
  end
end

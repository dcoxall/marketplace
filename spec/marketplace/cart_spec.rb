require 'spec_helper'

RSpec.describe Marketplace::Cart do
  describe 'adding an item' do
    context 'only 1' do
      it 'increments the cart item count' do
        expect { subject.add(double(:product), 1) }
          .to change(subject, :count).by(1)
      end
    end

    context 'amending quantity' do
      let(:product) { double(:product) }
      before { subject.add(product, 2) }

      it 'adjusts the cart item count' do
        expect { subject.add(product, -1) }
          .to change(subject, :count).from(2).to(1)
      end
    end

    context 'multiple' do
      it 'increments the cart item count' do
        expect { subject.add(double(:product), 3) }
          .to change(subject, :count).by(3)
      end
    end
  end
end

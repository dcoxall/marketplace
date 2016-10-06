module Marketplace
  module Promotion
    class CartTotalAdjustment
      def initialize(value:, discount:)
        @value = value
        @discount = discount
      end

      def applicable?(cart)
        cart.total >= @value
      end

      def adjustment(cart)
        cart.total * @discount * -1
      end
    end
  end
end

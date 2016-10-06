module Marketplace
  module Promotion
    class CartTotalAdjustment
      def initialize(value:, discount:)
        @value = value
        @discount = discount
      end

      def applicable?(_cart, total)
        total >= @value
      end

      def adjustment(_cart, total)
        total * @discount * -1
      end
    end
  end
end

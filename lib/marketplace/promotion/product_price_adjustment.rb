module Marketplace
  module Promotion
    class ProductPriceAdjustment
      def initialize(product_id:, trigger_quantity:, value:)
        @product_id = product_id
        @trigger_quantity = trigger_quantity
        @value = value
      end

      def applicable?(cart, total)
        cart.quantity_of(@product_id) >= @trigger_quantity
      end

      def adjustment(cart, total)
        qty = cart.quantity_of(@product_id)
        ((cart.price_of(@product_id) * qty) - (@value * qty)) * -1
      end
    end
  end
end

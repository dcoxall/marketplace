module Marketplace
  class Cart
    def initialize
      @items = []
    end

    def add(product, quantity)
      cart_item = find_cart_item(product)
      if cart_item
        cart_item.quantity += quantity
      else
        add_to_cart(product, quantity)
      end
    end

    def count
      @items.reduce(0) { |total, cart_item| total + cart_item.quantity }
    end

    private

    def add_to_cart(product, quantity)
      @items << CartItem.new(product, quantity)
    end

    def find_cart_item(product)
      @items.find { |cart_item| cart_item.product == product }
    end

    class CartItem
      attr_reader :product
      attr_accessor :quantity

      def initialize(product, quantity)
        @product = product
        @quantity = quantity
      end

      def hash
        [self.class, product, quantity].hash
      end

      def ==(other)
        other.is_a?(self.class) && other.hash == hash
      end
    end

    private_constant :CartItem
  end
end

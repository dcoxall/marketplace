module Marketplace
  class Cart
    def initialize
      @items = []
    end

    def add(product, quantity)
      cart_item = find_cart_item(product.id)
      if cart_item
        cart_item.quantity += quantity
      else
        add_to_cart(product, quantity)
      end
    end

    def count
      @items.reduce(0) { |total, cart_item| total + cart_item.quantity }
    end

    def total
      @items.reduce(BigDecimal(0)) do |total, cart_item|
        total + (cart_item.product.price * cart_item.quantity)
      end
    end

    def quantity_of(product_id)
      cart_item = find_cart_item(product_id)
      return 0 if cart_item.nil?
      cart_item.quantity
    end

    # I don't think this is the right option. I would have
    # prefered to have a product catalog where I can lookup
    # product details but for the sake of time I will leave
    # this comment instead
    def price_of(product_id)
      cart_item = find_cart_item(product_id)
      return nil if cart_item.nil?
      cart_item.product.price
    end

    private

    def add_to_cart(product, quantity)
      @items << CartItem.new(product, quantity)
    end

    def find_cart_item(product_id)
      @items.find { |cart_item| cart_item.product.id == product_id }
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

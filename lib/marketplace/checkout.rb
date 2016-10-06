module Marketplace
  class Checkout
    def initialize(promotion_rules = [])
      @promotion_rules = promotion_rules
      @cart = Marketplace::Cart.new
    end

    def scan(product)
      @cart.add(product, 1)
    end

    def total
      @promotion_rules.reduce(@cart.total) do |total, promotion|
        if promotion.applicable?(@cart, total)
          total + promotion.adjustment(@cart, total)
        else
          total
        end
      end.round(2)
    end
  end
end

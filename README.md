Marketplace
===========

Developed to demonstrate a way to approach a promotions engine in Ruby. This project demonstrates
the use of ruby duck typing to support multiple types of promotions whilst also using `BigDecimal`
and `Rational` to handle more complex arithmetic (requiring better precision and rounding
capabilities).

Development
-----------

To execute the test suite simply run

    $ bin/rspec -c

Considerations
--------------

If I spent more time on this I would like to make a `ProductCatalog` that allows other classes to
query the entire range of available products. This would then remove the need to have the `Cart`
fetch product data on behalf of the promotions.

The cart should probably track the applied promotions for receipts as well as then supporting
promotions that can only be supplied with no other promotion.

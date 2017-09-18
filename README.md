# Checkout

Basic module for handling a checkout cart. <br />
( subtracting the discounts). <br />
Offers a way to "scan" products into a cart and to calculate a total <br />
Only products from a predefined list(tshit, voucher , mug) can be scanned<br />
Please see https://gist.github.com/patriciagao/377dca8920ba3b1fc8da for more details

## Installation

 ~ git clone git@github.com:astoica1986/checkout.git <br />
 ~ cd checkout <br />
 ~ mix deps.get <br />
 ~ mix deps.compile <br />
 ~ mix test <br />

## Usage

~ iex -S mix <br />
iex(1)> alias Checkout.Cart <br />
iex(2)> cart = Checkout.create_cart <br />
iex(3)>Cart.scan(cart, "VOUCHER"); Cart.scan(cart, "TSHIRT"); <br />
iex(4)> Cart.scan(cart, "VOUCHER") <br />
iex(5)>Cart.total(cart) <br />

## TODO
*I'm thinking of writing additional tests for the Calculator module*  <br />
*Expand the features by including a way to delete an item from a cart(not in the initial requirements)* <br />
*Load the product list from a DB(it doesn't really make sense with such a short list)* <br />
*Calculate the total in its own process* <br />
*Maybe a create a small webservice for demo purposes* <br />
*Offer a way to customize the product list(related to possibly storing the list it in a DB)* <br />
*Think of a way to make the discount logic customizable* <br />

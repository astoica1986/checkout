defmodule CartTest do
  use ExUnit.Case
  alias Checkout.Cart
  doctest Cart


  setup do
    default_cart =
      %{
        mug: %{ price: 7.5, qty: 0 },
        tshirt: %{ price: 20.0, qty: 0 },
        voucher: %{ price: 5.0, qty: 0 }
      }
    pid = Checkout.create_cart
    { :ok, cart: pid, default_cart: default_cart }
  end

  describe "Cart.current_state/1" do
    test "returns a map with available products, each with qty and prices",
         %{ cart: cart, default_cart: default_cart } do
      assert Cart.current_state(cart) == default_cart
    end
  end

  describe "Cart.scan/2" do
    test "returns err message if product is not in the defined list",
        %{ cart: cart} do
      assert Cart.scan(cart, "dummy item") == "Product does not exist"
    end

    test "increments qty if product is in defined list", %{ cart: cart} do
      Cart.scan(cart, "tshirt")
      Cart.scan(cart, "tshirt")
      no_tshirts = Cart.current_state(cart)[:tshirt][:qty]
      assert no_tshirts == 2
    end
  end

  describe "Cart.total/1" do
    test "calculates cart total taking discount rules into account
          please visit the following link for details
          https://gist.github.com/patriciagao/377dca8920ba3b1fc8da" do
      cart = Checkout.create_cart
      Cart.scan(cart, "VOUCHER"); Cart.scan(cart, "TSHIRT"); Cart.scan(cart, "MUG");
      assert Cart.total(cart) == 32.50

      cart = Checkout.create_cart
      Cart.scan(cart, "VOUCHER"); Cart.scan(cart, "TSHIRT"); Cart.scan(cart, "VOUCHER");
      assert Cart.total(cart) == 25.00

      cart = Checkout.create_cart
      Cart.scan(cart, "TSHIRT"); Cart.scan(cart, "TSHIRT");
      Cart.scan(cart, "TSHIRT"); Cart.scan(cart, "VOUCHER");
      Cart.scan(cart, "TSHIRT")
      assert Cart.total(cart) == 81.00

      cart = Checkout.create_cart
      Cart.scan(cart, "VOUCHER"); Cart.scan(cart, "TSHIRT");
      Cart.scan(cart, "VOUCHER"); Cart.scan(cart, "VOUCHER");
      Cart.scan(cart, "MUG"); Cart.scan(cart, "TSHIRT");
      Cart.scan(cart, "TSHIRT")
      assert Cart.total(cart) == 74.50
    end
  end
end

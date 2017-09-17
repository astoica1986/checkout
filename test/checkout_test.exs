defmodule CheckoutTest do
  use ExUnit.Case
  doctest Checkout

  describe "Checkout.create_cart/1" do
    test "return a valid pid" do
      cart = Checkout.create_cart
      assert is_pid(cart)
    end
  end
end

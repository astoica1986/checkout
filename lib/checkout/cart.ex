defmodule Checkout.Cart do
  alias Checkout.Cart.ProductList
  alias Checkout.Cart.Calculator
  @moduledoc """
  Provides fucntions to add items to a cart and to calculate a total for that

  Example
  cart = Checkout.create_cart
  Cart.scan(cart, "VOUCHER"); Cart.scan(cart, "TSHIRT"); Cart.scan(cart, "VOUCHER");
  Cart.total(cart)
  """

  def start_link do
    Agent.start_link(fn -> %ProductList{} end)
  end

  def scan(cart, product) do
    product |> ProductList.validate_product |> update_cart(cart)
  end

  def current_state(cart) do
    Agent.get(cart, fn curr_cart -> curr_cart end)
    |> Map.from_struct
  end

  def total(cart) do
    cart |> current_state |> Map.to_list |> Calculator.calculate_total
  end

  defp update_cart({:ok, key}, cart) do
    Agent.update(cart, &increment_qty(&1, key))
  end

  defp update_cart({:error, error}, _cart) do
    IO.puts error
    error
  end

  defp increment_qty(cart, key) do
    updated_cart = cart
     |> Map.from_struct
     |> Kernel.update_in([key, :qty], &(&1 + 1))
    struct(ProductList, updated_cart)
  end
end

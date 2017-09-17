defmodule Checkout.Cart.Calculator do
  @moduledoc """
  Calculates a sum considering the discounts defined for certain products
  """
  def calculate_total(cart) do
    cart |> Enum.reduce(0, &calculate_sum/2)
  end

  def calculate_sum(el, acc) do
    {product, %{price: price, qty: qty}} = el
    price * qty - calculate_discount(product, price, qty) + acc
  end

  def calculate_discount(:tshirt, _price, qty) when qty > 2 do
    qty
  end

  def calculate_discount(:voucher, price, qty) when qty > 1 do
    div(qty, 2) * price
  end

  def calculate_discount(_, _, _) do
    0
  end
end

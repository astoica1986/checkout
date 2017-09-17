defmodule Checkout.Cart.ProductList do
  defstruct voucher: %{qty: 0, price: 5.00},
            tshirt: %{qty: 0, price: 20.00},
            mug: %{qty: 0, price: 7.50}    

  def validate_product(product) do
    key = to_key(product)
    if Map.has_key?(%Checkout.Cart.ProductList{}, key) do
      {:ok, key}
    else
      {:error, "Product does not exist"}
    end
  end

  defp to_key(product) do
    product |> String.downcase |> String.to_atom
  end
end

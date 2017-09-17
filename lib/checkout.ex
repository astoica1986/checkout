defmodule Checkout do
  use Application
  alias Checkout.Cart
  
  def start(_type, _args) do
    Checkout.Supervisor.start_link
  end

  def create_cart do
    {:ok, cart_pid} = Checkout.Cart.Supervisor.create_cart
    cart_pid
  end
end

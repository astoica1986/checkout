defmodule Checkout.Cart.Supervisor do
  use Supervisor
  @name Checkout.Cart.Supervisor

  @doc """
  Start the cart agent supervisor and link it to the calling process.
  """
  def start_link() do
     Supervisor.start_link(@name, :ok, name: @name)
  end

  @doc """
  Create a new cart.
  """
  def create_cart do
    Supervisor.start_child(@name, [])
  end

  def init(:ok) do
    children = [
      worker(Checkout.Cart, [])
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end

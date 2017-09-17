defmodule Checkout.Supervisor do
  use Supervisor
  
  @doc """
  Start the supervisor and link it to the calling process.
  """
  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      supervisor(Checkout.Cart.Supervisor, [])
    ]

    supervise(children, strategy: :rest_for_one)
  end
end

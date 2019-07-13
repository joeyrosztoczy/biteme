defmodule Biteme.Cache do
  use GenServer

  # Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: :boom_daddy)
  end

  # Server Implentation
  def init(state) do
    IO.puts("BOOM")
    IO.inspect(state)
    {:ok, state}
  end
end

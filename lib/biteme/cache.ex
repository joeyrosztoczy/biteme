defmodule Biteme.Cache do
  use GenServer

  # Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def insert_url(url) do
    GenServer.call(__MODULE__, {:insert_url, url})
  end

  # Server Implentation
  def init(state) do
    {:ok, state}
  end

  def handle_call({:insert_url, url}, _from, state) do
    IO.puts("SUP DUDE")
    IO.inspect(url)
    {:reply, {:ok, url}, state}
  end
end

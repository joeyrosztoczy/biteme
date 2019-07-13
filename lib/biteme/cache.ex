defmodule Biteme.Cache do
  use GenServer

  alias Biteme.Shortener

  # Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def insert_url(url) do
    GenServer.call(__MODULE__, {:insert_url, url})
  end

  # Server Implentation
  def init(state) do
    {:ok, state, {:continue, :load_urls}}
  end

  def handle_call({:insert_url, url}, _from, state) do
    ConCache.put(:slug_cache, url.id, url.original_url)
    {:reply, {:ok, url}, state}
  end

  def handle_continue(:load_urls, state) do
    urls = Shortener.list_urls()

    Enum.each(urls, fn url ->
      ConCache.put(:slug_cache, url.id, url.original_url)
    end)

    {:noreply, state}
  end
end

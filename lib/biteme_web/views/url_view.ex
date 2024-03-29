defmodule BitemeWeb.UrlView do
  use BitemeWeb, :view
  alias BitemeWeb.UrlView

  def render("index.json", %{urls: urls}) do
    %{data: render_many(urls, UrlView, "url.json")}
  end

  def render("show.json", %{url: url}) do
    %{data: render_one(url, UrlView, "url.json")}
  end

  def render("url.json", %{url: url}) do
    short_url = Base62.encode(url.id)
    %{id: url.id, original_url: url.original_url, short_url: short_url}
  end
end

defmodule BitemeWeb.UrlController do
  use BitemeWeb, :controller

  alias Biteme.Shortener
  alias Biteme.Shortener.Url

  action_fallback BitemeWeb.FallbackController

  def index(conn, _params) do
    urls = Shortener.list_urls()
    render(conn, "index.json", urls: urls)
  end

  def create(conn, %{"url" => url_params}) do
    with {:ok, %Url{} = url} <- Shortener.create_url(url_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.url_path(conn, :show, url))
      |> render("show.json", url: url)
    end
  end

  def short_url_redirect(conn, %{"short_url" => short_url}) do
    # Take short URL, and use it to get the long URL.
    {:ok, id} = Base62.decode(short_url)
    url = Shortener.get_url!(id)
    redirect(conn, external: url.original_url)
  end

  def show(conn, %{"id" => id}) do
    url = Shortener.get_url!(id)
    render(conn, "show.json", url: url)
  end

  def update(conn, %{"id" => id, "url" => url_params}) do
    url = Shortener.get_url!(id)

    with {:ok, %Url{} = url} <- Shortener.update_url(url, url_params) do
      render(conn, "show.json", url: url)
    end
  end

  def delete(conn, %{"id" => id}) do
    url = Shortener.get_url!(id)

    with {:ok, %Url{}} <- Shortener.delete_url(url) do
      send_resp(conn, :no_content, "")
    end
  end
end

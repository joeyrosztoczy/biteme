defmodule BitemeWeb.UrlControllerTest do
  use BitemeWeb.ConnCase

  alias Biteme.Shortener
  alias Biteme.Shortener.Url

  @create_attrs %{
    original_url: "some original_url"
  }
  @update_attrs %{
    original_url: "some updated original_url"
  }
  @invalid_attrs %{original_url: nil}

  def fixture(:url) do
    {:ok, url} = Shortener.create_url(@create_attrs)
    url
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "redirect short url" do
    test "redirects", %{conn: conn} do
      {:ok, url} = Shortener.create_url(@create_attrs)
      short_url = Base62.encode(url.id)
      conn = get(conn, Routes.url_path(conn, :short_url_redirect, short_url))
      assert conn.status == 302
    end
  end

  describe "create url" do
    test "renders url when data is valid", %{conn: conn} do
      conn = post(conn, Routes.url_path(conn, :create), url: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.url_path(conn, :show, id))

      assert %{
               "id" => id,
               "original_url" => "some original_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.url_path(conn, :create), url: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update url" do
    setup [:create_url]

    @tag :skip
    test "renders url when data is valid", %{conn: conn, url: %Url{id: id} = url} do
      conn = put(conn, Routes.url_path(conn, :update, url), url: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.url_path(conn, :show, id))

      assert %{
               "id" => id,
               "original_url" => "some updated original_url"
             } = json_response(conn, 200)["data"]
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn, url: url} do
      conn = put(conn, Routes.url_path(conn, :update, url), url: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete url" do
    setup [:create_url]

    test "deletes chosen url", %{conn: conn, url: url} do
      conn = delete(conn, Routes.url_path(conn, :delete, url))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.url_path(conn, :show, url))
      end
    end
  end

  defp create_url(_) do
    url = fixture(:url)
    {:ok, url: url}
  end
end

defmodule Biteme.ShortenerTest do
  use Biteme.DataCase

  alias Biteme.Shortener

  describe "urls" do
    alias Biteme.Shortener.Url

    @valid_attrs %{original_url: "some original_url"}
    @update_attrs %{original_url: "some updated original_url"}
    @invalid_attrs %{original_url: nil}

    def url_fixture(attrs \\ %{}) do
      {:ok, url} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shortener.create_url()

      url
    end

    test "list_urls/0 returns all urls" do
      url = url_fixture()
      assert Shortener.list_urls() == [url]
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert Shortener.get_url!(url.id) == url
    end

    test "create_url/1 with valid data creates a url" do
      assert {:ok, %Url{} = url} = Shortener.create_url(@valid_attrs)
      assert url.original_url == "some original_url"
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortener.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()
      assert {:ok, %Url{} = url} = Shortener.update_url(url, @update_attrs)
      assert url.original_url == "some updated original_url"
    end

    test "update_url/2 with invalid data returns error changeset" do
      url = url_fixture()
      assert {:error, %Ecto.Changeset{}} = Shortener.update_url(url, @invalid_attrs)
      assert url == Shortener.get_url!(url.id)
    end

    test "delete_url/1 deletes the url" do
      url = url_fixture()
      assert {:ok, %Url{}} = Shortener.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> Shortener.get_url!(url.id) end
    end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = Shortener.change_url(url)
    end
  end
end

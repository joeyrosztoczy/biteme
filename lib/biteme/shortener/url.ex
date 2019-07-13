defmodule Biteme.Shortener.Url do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :original_url, :string

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:original_url])
    |> validate_required([:original_url])
  end
end

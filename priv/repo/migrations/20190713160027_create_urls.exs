defmodule Biteme.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :original_url, :string

      timestamps()
    end

  end
end

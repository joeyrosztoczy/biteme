defmodule Biteme.Repo.Migrations.AddUniqueConstraintToOriginalUrl do
  use Ecto.Migration

  def change, do: create(unique_index(:urls, [:original_url]))
end

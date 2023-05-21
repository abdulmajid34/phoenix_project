defmodule PhoenixFramework.Worlds.Space do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :string, autogenerate: false}
  @foreign_key_type :string
  schema "spaces" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(space, attrs) do
    space
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end

  def create_changeset(space, attrs) do
    space
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> put_change(:id, PhoenixFramework.Utils.random_string(5))
  end
end

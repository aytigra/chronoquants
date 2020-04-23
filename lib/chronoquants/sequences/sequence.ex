defmodule Chronoquants.Sequences.Sequence do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chronoquants.Users.User

  schema "sequences" do
    field :name, :string
    field :public, :boolean, default: false
    field :summary, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(sequence, attrs) do
    sequence
    |> cast(attrs, [:name, :public, :summary])
    |> validate_required([:name])
  end
end

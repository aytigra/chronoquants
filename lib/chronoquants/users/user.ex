defmodule Chronoquants.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use Pow.Extension.Ecto.Schema,
    extensions: [PowResetPassword, PowEmailConfirmation, PowPersistentSession]
  use PowAssent.Ecto.Schema

  schema "users" do
    field :name, :string

    pow_user_fields()

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> pow_extension_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [:name])
    |> Ecto.Changeset.validate_required([:name])
  end

  def user_identity_changeset(user_or_changeset, user_identity, attrs, user_id_attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:name])
    |> pow_assent_user_identity_changeset(user_identity, attrs, user_id_attrs)
  end
end

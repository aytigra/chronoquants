defmodule Chronoquants.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: Chronoquants.Repo

  def user_factory do
    %Chronoquants.Users.User{
      name: sequence(:name, &"Test User #{&1}"),
      email: sequence(:email, &"email-#{&1}@example.com"),
      password_hash: Base.encode64("test1234"),
    }
  end

  def sequence_factory do
    %Chronoquants.Sequences.Sequence{
      name: sequence(:name, &"Test Sequence #{&1}"),
      user: build(:user),
    }
  end
end

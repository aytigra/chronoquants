defmodule ChronoquantsWeb.PowResetPassword.MailerView do
  use ChronoquantsWeb, :mailer_view

  def subject(:reset_password, _assigns), do: "Reset password link"
end

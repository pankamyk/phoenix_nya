defmodule NyaWeb.Session do
  use(Guardian, otp_app: :nya)

  alias Nya.{ Accounts, Accounts.User }

  def subject_for_token(%User{} = res, _), do: { :ok, to_string(res.id) }

  def subject_for_token(_, _), do: { :error, :no_resource }


  def resource_from_claims(%{ "sub" => id } = claims) do
    case Accounts.get_user(id) do
      nil -> { :error, :not_found }
      res -> { :ok, res }
    end
  end

  def resource_from_claims(_), do: { :error, :bad_claims }
end




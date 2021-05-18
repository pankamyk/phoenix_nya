defmodule NyaWeb.Guardian do
  use(Guardian, otp_app: :nya)

  alias Nya.{ Accounts, Accounts.User }

  def subject_for_token(%User{} = res, _), do: { :ok, to_string(res.id) }

  def subject_for_token(_, _), do: { :error, :no_subject }


  def resource_from_claims(%{ "sub" => id }) do
    case Accounts.get_user(id) do
      %User{} = res -> 
        { :ok, res }

      nil -> 
        { :error, :not_found }
    end
  end

  def resource_from_claims(_), do: { :error, :bad_claims }
end




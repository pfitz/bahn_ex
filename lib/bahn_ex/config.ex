defmodule BahnEx.Config do
  @moduledoc """
  Config managament for the BahnEx API Wrapper.
  """

  @doc """
  Checks the enviroment variable for an api key. If there is non it checks the config for
  a possible key.

  Returns the api key string
  """
  @spec get_api_key :: String.t
  def get_api_key do
    key = System.get_env("BAHNEX_API_KEY")
    check_config_for_key(key)
  end

  @spec check_config_for_key(String.t) :: String.t | nil
  defp check_config_for_key(key) when is_binary(key), do: key
  defp check_config_for_key(_) do
    case File.regular?("config/bahn_ex_secret.exs") do
      true ->
        Application.get_env(:bahn_ex, :api_key)
      false ->
        nil
    end
  end
end

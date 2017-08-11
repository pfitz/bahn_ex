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

  @spec check_config_for_key(String.t) :: String.t
  defp check_config_for_key(key) when is_binary(key) and byte_size(key) == 0 do
    Application.get_env(:bahn_ex, :api_key)
  end

  defp check_config_for_key(key), do: key
end

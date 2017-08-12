defmodule BahnEx.ConfigTest do
  use ExUnit.Case, async: false


  import Mock

  alias BahnEx.Config

  @enviroment "system_enviroment"
  @file_env "file_api_key"

  test "get_api_key() returns the enviroment variable if there is one" do
    with_mock System, [get_env: fn (_var)-> @enviroment end] do
      assert @enviroment == Config.get_api_key()
    end
  end

  test "get_api_key() returns the api key from the config file" do
    with_mocks([
      {File, [], [regular?: fn (_) -> true end]},
      {Application, [], [get_env: fn (_,_)-> @file_env end]}
    ]) do
      assert @file_env == Config.get_api_key()
    end
  end
 end
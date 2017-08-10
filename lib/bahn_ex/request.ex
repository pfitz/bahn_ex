defmodule BahnEx.Request do
  @moduledoc """
  Generates the request to the DB Fahrplan API
  """

  @header %{"Authorization" => "Bearer #{Application.get_env(:bahn_ex, :api_key)}", "Accept" => "Application/json; Charset=utf-8"}
  @base_url "https://api.deutschebahn.com/fahrplan-plus/v1/"

  @spec location(String.t) :: {:ok, HTTPoison.Response.t | HTTPoison.AsyncResponse.t} | {:error, HTTPoison.Error.t}
  def location(location) do
    url = @base_url <> "location/#{location}?lang=de&format=json"
    HTTPoison.get(url, @header)
  end
end
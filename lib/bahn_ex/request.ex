defmodule BahnEx.Request do
  @moduledoc """
  Generates the request to the DB Fahrplan API
  """

  alias BahnEx.Config

  @header %{"Authorization" => "Bearer #{Config.get_api_key()}", "Accept" => "Application/json; Charset=utf-8"}
  @base_url "https://api.deutschebahn.com/fahrplan-plus/v1/"

  @spec location(String.t) :: {:ok, HTTPoison.Response.t | HTTPoison.AsyncResponse.t} | {:error, HTTPoison.Error.t}
  def location(location) do
    url = @base_url <> "location/#{location}?lang=de&format=json"
    HTTPoison.get(url, @header)
  end

  @spec arrival_board(non_neg_integer(), Calendar.datetime)
    :: {:ok, HTTPoison.Response.t | HTTPoison.AsyncResponse.t} | {:error, HTTPoison.Error.t}
  def arrival_board(id, dateTime) do
    url = @base_url <> "arrivalBoard/#{id}"
    HTTPoison.get(url, @header, params: %{date: dateTime})
  end

  @spec departure_board(non_neg_integer(), Calendar.datetime)
    :: {:ok, HTTPoison.Response.t | HTTPoison.AsyncResponse.t} | {:error, HTTPoison.Error.t}
  def departure_board(id, dateTime) do
    url = @base_url <> "departureBoard/#{id}"
    HTTPoison.get(url, @header, params: %{date: dateTime})
  end

  @spec journey_details(String.t)
    :: {:ok, HTTPoison.Response.t | HTTPoison.AsyncResponse.t} | {:error, HTTPoison.Error.t}
  def journey_details(id) do
    url = @base_url <> "journeyDetails/#{id}"
    HTTPoison.get(url, @header)
  end
end

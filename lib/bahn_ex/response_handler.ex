defmodule BahnEx.ResponseHandler do
  @moduledoc """
  Handles the responses of the DB Fahrplan API and tries to convert the json body in appropiate
  structs
  """

  alias BahnEx.Location
  require Logger

  @spec handle_location_response({:ok, HTTPoison.Response.t | HTTPoison.AsyncResponse.t} |
    {:error, HTTPoison.Error.t}) :: list(BahnEx.Location.t | nil)
  def handle_location_response(response) do
    handle_response(response, [%Location{}])
  end

  @spec handle_response({:ok, HTTPoison.Response.t | HTTPoison.AsyncResponse.t}, list()) ::
    list() | nil
  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}, decode_as) do
      Poison.decode!(body, as: decode_as)
  end

  @spec handle_response({:ok, HTTPoison.Response.t | HTTPoison.AsyncResponse.t}, list()) :: nil
  defp handle_response({:ok, %HTTPoison.Response{status_code: 401, body: body}}, _) do
    error = Poison.decode!(body)
    IO.puts "Error: Code: #{error["error"]["code"]} \n
      Description:#{error["error"]["description"]} \n
      Message:#{error["error"]["message"]}"
    nil
  end

  @spec handle_response({:ok, HTTPoison.Response.t | HTTPoison.AsyncResponse.t}, list()) :: nil
  defp handle_response({:ok, %HTTPoison.Response{status_code: 404, body: body}}, _) do
    Logger.warn "404 - Not Found : " <> body
    nil
  end

  @spec handle_response({:ok, HTTPoison.Response.t | HTTPoison.AsyncResponse.t}, list()) :: nil
  defp handle_response({:ok, %HTTPoison.Response{status_code: 500, body: body}}, _) do
    Logger.warn "500 - Internal Server Error : " <> body
    nil
  end

  @spec handle_response({:ok, HTTPoison.Response.t | HTTPoison.AsyncResponse.t}, list()) :: nil
  defp handle_response({:ok, %HTTPoison.Response{status_code: 502, body: body}}, _) do
    Logger.warn "502 - The service has been disabled temporarily. : " <> body
    nil
  end

  @spec handle_response({:error, HTTPoison.Error.t}, list()) :: nil
  defp handle_response({:error , %HTTPoison.Error{reason: :nxdomain}}, _) do
    Logger.warn "Unknown domain"
    nil
  end
end

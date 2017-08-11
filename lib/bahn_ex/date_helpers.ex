defmodule BahnEx.DateHelpers do
  @moduledoc """
  little helpers for working with dates in the DB Fahrplan API.
  """

  @doc """
  Converts the string into a ISO 8601 `DateTime`.

  Returns the converted string or if it cannot convert the string the current date and time
  as `DateTime`.
  """
  @spec iso_8601_date_from_string(String.t) :: Calendar.datetime
  def iso_8601_date_from_string(string) when is_binary(string) do
    string
    |> DateTime.from_iso8601()
    |> ensure_valid_date_time()
  end

  defp ensure_valid_date_time({:ok, %DateTime{} = dt, _}) do
    dt
  end

  defp ensure_valid_date_time({:error, _}) do
    DateTime.utc_now()
  end
end

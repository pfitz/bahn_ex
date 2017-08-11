defmodule BahnEx.ArrivalBoard do
  @moduledoc """
  The modul for the arrival board part of the DB Fahrplan api.
  """

  alias BahnEx.{DateHelpers, ResponseHandler, Request}

  @doc """
  Get arrival board at a given location at a given daten and time.

  id_or_location: either a `integer` id or a `%BahnEx.Location{}`
  iso_8601_date_time: a `Calendar.dateTime` or a `string` in ISO8601 date and time format

  Returns: a list of `%BahnEx.Train{}` for the given station and time.
  """
  @spec get_arrivals(non_neg_integer() | BahnEx.Location.t , Calendar.datetime | String.t) :: list(BahnEx.Train.t)
  def get_arrivals(station_id, iso_8601_date_time) when is_integer(station_id)
      and is_binary(iso_8601_date_time) do

    date = DateHelpers.iso_8601_date_from_string(iso_8601_date_time)
    station_id
    |> get_arrivals(date)
  end

  def get_arrivals(%BahnEx.Location{} = location, iso_8601_date_time)
    when is_binary(iso_8601_date_time) do
      date = DateHelpers.iso_8601_date_from_string(iso_8601_date_time)
      location
      |> get_arrivals(date)
  end

  def get_arrivals(%BahnEx.Location{} = location, iso_8601_date_time) do
    get_arrivals(location.id, iso_8601_date_time)
  end

  def get_arrivals(station_id, %DateTime{} = iso_8601_date_time) when is_integer(station_id) do
    station_id
    |> Request.arrival_board(iso_8601_date_time)
    |> ResponseHandler.handle_arrival_board_response()
  end
end

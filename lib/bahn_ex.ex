defmodule BahnEx do
  @moduledoc """
  An Elixir wrapper for the [Deutsche Bahn (DB) Fahrplan API](https://developer.deutschebahn.com/store/apis/info?name=Fahrplan&version=v1&provider=DBOpenData)
  """

  @doc """
  Get information about locations matching the given name or name fragment `name_or_fragment`

  Returns a list of `%BahnEx.Location{}`

  ## Examples

    iex>BahnEx.location("Dresden")
    [%BahnEx.Location{id: 8010085, lat: 51.040562, lon: 13.732039, name: "Dresden Hbf"},
     %BahnEx.Location{id: 8010089, lat: 51.065903, lon: 13.740704, name: "Dresden-Neustadt"}]
  """
  defdelegate location(name_or_fragment), to: BahnEx.Location, as: :get_location

  @doc """
  Get arrival board at a given location at a given daten and time.

  id_or_location: either a `integer` id or a `%BahnEx.Location{}`
  iso_8601_date_time: a `Calendar.dateTime` or a `string` in ISO8601 date and time format

  Returns: a list of `%BahnEx.Train{}` for the given station and time.

  ## Examples

     iex(1)> BahnEx.arrival_board(8010085, "2017-08-23T19:00:00Z")
     [%BahnEx.Train{boardId: 8010085, dateTime: #DateTime<2017-08-23 19:35:00Z>,
       detailsId: "304116%2F104694%2F528716%2F162986%2F80%3fstation_evaId%3D8010085",
       name: "ICE 1653", origin: "Frankfurt(M) Flughafen Fernbf", stopId: 8010085,
       stopName: "Dresden Hbf", track: "3", type: "ICE"},
      %BahnEx.Train{boardId: 8010085, dateTime: #DateTime<2017-08-23 20:36:00Z>,
       detailsId: "521202%2F179326%2F919084%2F285808%2F80%3fstation_evaId%3D8010085",
       name: "IC 2047", origin: "Dortmund Hbf", stopId: 8010085,
       stopName: "Dresden Hbf", track: "1", type: "IC"}]

  """
  defdelegate arrival_board(id_or_location, iso_8601_date_time), to: BahnEx.ArrivalBoard, as: :get_arrivals

  @doc """
  Get departure board at a given location at a given daten and time.

  id_or_location: either a `integer` id or a `%BahnEx.Location{}`
  iso_8601_date_time: a `Calendar.dateTime` or a `string` in ISO8601 date and time format

  Returns: a list of `%BahnEx.Train{}` for the given station and time.

  ## Examples

     iex(1)> BahnEx.arrival_board(8010085, "2017-08-23T19:00:00Z")
     [%BahnEx.Train{boardId: 8010085, dateTime: #DateTime<2017-08-23 19:35:00Z>,
       detailsId: "304116%2F104694%2F528716%2F162986%2F80%3fstation_evaId%3D8010085",
       name: "ICE 1653", origin: "Frankfurt(M) Flughafen Fernbf", stopId: 8010085,
       stopName: "Dresden Hbf", track: "3", type: "ICE"},
      %BahnEx.Train{boardId: 8010085, dateTime: #DateTime<2017-08-23 20:36:00Z>,
       detailsId: "521202%2F179326%2F919084%2F285808%2F80%3fstation_evaId%3D8010085",
       name: "IC 2047", origin: "Dortmund Hbf", stopId: 8010085,
       stopName: "Dresden Hbf", track: "1", type: "IC"}]

  """
  defdelegate departure_board(id_or_location, iso_8601_date_time), to: BahnEx.DepartureBoard, as: :get_departures
  @doc """
  Retrieve details of a journey. The id of journey should come from an arrival board or a departure
  board.

  id: Either a `%BahnEx.Train{}` struct or an string id

  Returns a list of `%BahnEx.TrainLoc{}`s.

  ## Examples

      iex(1)> BahnEx.journey_details("475620%252F175342%252F176320%252F70380%252F80%253fstation_evaId%253D8010085")
      https://api.deutschebahn.com/fahrplan-plus/v1/journeyDetails/475620%252F175342%252F176320%252F70380%252F80%253fstation_evaId%253D8010085
      [%BahnEx.TrainLoc{arrTime: nil, depTime: ~T[07:03:00], lat: "52.525589",
        lon: "13.369549", operator: "DPN", stopId: 8098160,
        stopName: "Berlin Hbf (tief)", train: "EC 171", type: "EC"},
       %BahnEx.TrainLoc{arrTime: ~T[07:08:00], depTime: ~T[07:10:00],
        lat: "52.475043", lon: "13.365315", operator: "DPN", stopId: 8011113,
        stopName: "Berlin Südkreuz", train: "EC 171", type: "EC"}]

  """
  defdelegate journey_details(id_or_train_struct), to: BahnEx.JourneyDetails, as: :get_journey_details
end

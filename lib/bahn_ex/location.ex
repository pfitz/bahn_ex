defmodule BahnEx.Location do
  @moduledoc """
   Wrapper around the location endpoint of the DB Fahrplan API
  """

  alias BahnEx.{Request, ResponseHandler}
  require Logger

  @type t :: %__MODULE__{name: String.t, lat: float, lon: float, id: non_neg_integer}
  @derive [Poison.Encoder]
  defstruct [:name, :lat, :lon, :id]

  @doc """
  Get information about locations matching the given name or name fragment `name_or_fragment`

  Returns a list of `%BahnEx.Location{}`

  ## Examples

    iex>BahnEx.Location.get_location("Dresden")
    [%BahnEx.Location{id: 8010085, lat: 51.040562, lon: 13.732039, name: "Dresden Hbf"},
     %BahnEx.Location{id: 8010089, lat: 51.065903, lon: 13.740704, name: "Dresden-Neustadt"}]

  """
  @spec get_location(String.t) :: list(BahnEx.Location.t) | nil
  def get_location(name_or_fragment) when is_binary(name_or_fragment) do
    name_or_fragment
    |> Request.location()
    |> ResponseHandler.handle_location_response()
  end
end

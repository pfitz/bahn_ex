defmodule BahnEx do
  @moduledoc """
  An Elixir wrapper for the [Deutsche Bahn (DB) Fahrplan API](https://developer.deutschebahn.com/store/apis/info?name=Fahrplan&version=v1&provider=DBOpenData)
  """

  @doc """
  Get information about locations matching the given name or name fragment `name_or_fragment`

  Returns a list of `%BahnEx.Location{}`

  ## Examples

    iex>BahnEx.get_location("Dresden")
    [%BahnEx.Location{id: 8010085, lat: 51.040562, lon: 13.732039, name: "Dresden Hbf"},
     %BahnEx.Location{id: 8010089, lat: 51.065903, lon: 13.740704, name: "Dresden-Neustadt"}]
  """
  defdelegate get_location(name_or_fragment), to: BahnEx.Location
end

defmodule BahnEx.TrainLoc do
  @moduledoc """
  Value struct for results of the journey details endpoint.
  """

  @type t :: %__MODULE__{
               stopId: non_neg_integer(),
               stopName: String.t,
               lat: float,
               lon: float,
               arrTime: %Time{} | nil,
               depTime: %Time{} | nil,
               train: String.t,
               type: String.t,
               operator: String.t
             }
  @derive [Poison.Encoder]
  defstruct [:stopId, :stopName, :lat, :lon, :arrTime, :depTime, :train, :type, :operator]

  defimpl Poison.Decoder, for: BahnEx.TrainLoc do
    def decode(%{arrTime: arr_string, depTime: dep_string} = train_loc, _options) do
      %{train_loc | arrTime: cast_non_nil_time(arr_string), depTime: cast_non_nil_time(dep_string)}
    end

    defp cast_non_nil_time(time_string) when is_nil(time_string), do: nil

    defp cast_non_nil_time(time_string) when is_binary(time_string) do
      {:ok, parsed_time} =
        time_string <> ":00"
        |> Time.from_iso8601()
      parsed_time
    end
  end
end
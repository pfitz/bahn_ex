defmodule BahnEx.Train do
  @moduledoc """
  Value struct for trains.
  """

  @type t :: %__MODULE__{
               name: String.t,
               type: String.t,
               boardId: non_neg_integer(),
               stopId: non_neg_integer(),
               stopName: String.t,
               dateTime: Calendar.datetime,
               origin: String.t,
               track: String.t,
               detailsId: String.t
             }
  @derive [Poison.Encoder]
  defstruct [:name, :type, :boardId, :stopId, :stopName, :dateTime, :origin, :track, :detailsId]

  defimpl Poison.Decoder, for: BahnEx.Train do
    def decode(%{dateTime: date_time} = train, _options) do
      {:ok, dt, _} =
        date_time <> ":00Z"
        |> DateTime.from_iso8601
      %{train | dateTime: dt}
    end

  end
end
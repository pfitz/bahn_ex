defmodule BahnEx.JourneyDetails do
  @moduledoc """
  The module for the journey details endpoint of the DB Fahrplan API.
  """

  alias BahnEx.{Request, ResponseHandler}

  @doc """
  Retrieve details of a journey. The id of journey should come from an arrival board or a departure
  board.

  id: Either a `%BahnEx.Train{}` struct or an string id

  Returns a list of `%BahnEx.TrainLoc{}`s.
  """
  @spec get_journey_details(BahnEx.Train.t | String.t) :: list(BahnEx.TrainLoc.t)
  def get_journey_details(%BahnEx.Train{detailsId: id}) when is_binary(id) do
    get_journey_details(id)
  end

  def get_journey_details(id) when is_binary(id) do
    id
    |> Request.journey_details()
    |> ResponseHandler.handle_journey_details_response()
  end
end

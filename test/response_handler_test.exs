defmodule ResponseHandlerTest do
  use ExUnit.Case, async: true

  alias BahnEx.ResponseHandler
  alias HTTPoison.Response

  @location_json """
  [
    {
      "name": "Dresden Hbf",
      "lon": 13.732039,
      "lat": 51.040562,
      "id": 8010085
    },
    {
      "name": "Dresden-Neustadt",
      "lon": 13.740704,
      "lat": 51.065903,
      "id": 8010089
    }
  ]
  """

  @arrival_json """
    [
      {
        "name": "IC 2443",
        "type": "IC",
        "boardId": 8010085,
        "stopId": 8010085,
        "stopName": "Dresden Hbf",
        "dateTime": "2017-08-19T14:36",
        "origin": "Dortmund Hbf",
        "track": "1",
        "detailsId": "843048%2F290311%2F256180%2F152926%2F80%3fstation_evaId%3D8010085"
      },
      {
        "name": "EC 378",
        "type": "EC",
        "boardId": 8010085,
        "stopId": 8010085,
        "stopName": "Dresden Hbf",
        "dateTime": "2017-08-19T14:43",
        "origin": "Praha hl.n.",
        "track": "17",
        "detailsId": "970731%2F341609%2F520018%2F63568%2F80%3fstation_evaId%3D8010085"
      }
    ]
    """

  test "404 - Response returns nil" do
    mockresponse = {:ok, %Response{status_code: 404, body: "body"}}
    assert nil == ResponseHandler.handle_location_response(mockresponse)
  end

  test "500 - Response returns nil" do
    mockresponse = {:ok, %Response{status_code: 500, body: "body"}}
    assert nil == ResponseHandler.handle_location_response(mockresponse)
  end

  test "502 - Response returns nil" do
    mockresponse = {:ok, %Response{status_code: 502, body: "body"}}
    assert nil == ResponseHandler.handle_location_response(mockresponse)
  end

  test "unknown domain - returns nil" do
    mockresponse = {:error , %HTTPoison.Error{reason: :nxdomain}}
    assert nil == ResponseHandler.handle_location_response(mockresponse)
  end

  test "response handler converts successful location response from json to %BahnEx.Location{} struct" do
    mockresponse = {:ok, %Response{status_code: 200, body: @location_json}}
    result = ResponseHandler.handle_location_response(mockresponse)
    assert 2 == length(result)
    assert [%BahnEx.Location{}, %BahnEx.Location{}] = result
  end

  test "response handler converts successful arrival board responses from json into %BahnEx.Train structs" do
    mockresponse = {:ok, %Response{status_code: 200, body: @arrival_json}}
    result = ResponseHandler.handle_arrival_board_response(mockresponse)
    assert 2 == length(result)
    assert [%BahnEx.Train{}, %BahnEx.Train{}] = result
  end
end
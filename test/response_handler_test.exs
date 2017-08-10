defmodule ResponseHandlerTest do
  use ExUnit.Case

  alias BahnEx.ResponseHandler
  alias HTTPoison.Response

  @jsonbody """
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
    mockresponse = {:ok, %Response{status_code: 200, body: @jsonbody}}
    result = ResponseHandler.handle_location_response(mockresponse)
    assert 2 == length(result)
    assert [%BahnEx.Location{}, %BahnEx.Location{}] = result
  end
end
defmodule BahnEx.RequestTest do
  use ExUnit.Case, async: false

  import Mock

  alias BahnEx.{Config, Request}

  @header %{"Authorization" => "Bearer #{Config.get_api_key()}", "Accept" => "Application/json; Charset=utf-8"}

  test "location request is getting called with the right url" do
    with_mock HTTPoison, [get: fn(_url,_header) -> "<html></html>" end] do
      _response = Request.location("test")
      assert called HTTPoison.get("https://api.deutschebahn.com/fahrplan-plus/v1/location/test", @header)
    end
  end

  test "arrival board is getting called with the correct url" do
    with_mock HTTPoison, [get: fn(_url, _header, _date) -> "<html></html>" end] do
      _response = Request.arrival_board(8000096, "2017-08-20T10:30:00Z")
      assert called HTTPoison.get("https://api.deutschebahn.com/fahrplan-plus/v1/arrivalBoard/8000096",
        @header, params: %{date: "2017-08-20T10:30:00Z"})
    end
  end

  test "departure board is getting called with the correct url" do
    with_mock HTTPoison, [get: fn(_url, _header, _date) -> "<html></html>" end] do
      _response = Request.departure_board(8000096, "2017-08-20T10:30:00Z")
      assert called HTTPoison.get("https://api.deutschebahn.com/fahrplan-plus/v1/departureBoard/8000096",
        @header, params: %{date: "2017-08-20T10:30:00Z"})
    end
  end

  test "journey details request is getting called with the right url" do
    with_mock HTTPoison, [get: fn(_url,_header) -> "<html></html>" end] do
      _response = Request.journey_details("test")
      assert called HTTPoison.get("https://api.deutschebahn.com/fahrplan-plus/v1/journeyDetails/test", @header)
    end
  end
end

defmodule DateHelperTest do
  use ExUnit.Case, async: true

  test "datehelper converts valid iso 8601 date string into DateTime" do
    assert %DateTime{} = BahnEx.DateHelpers.iso_8601_date_from_string("2017-08-20T19:00:00Z")
  end

  test "datehelper returns the current date and time for a invald string" do
    now = DateTime.utc_now
    wrong = BahnEx.DateHelpers.iso_8601_date_from_string("wrong")
    assert DateTime.diff(now, wrong) == 0
  end
end
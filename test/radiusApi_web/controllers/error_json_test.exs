defmodule RadiusApiWeb.ErrorJSONTest do
  use RadiusApiWeb.ConnCase, async: true

  test "renders 404" do
    assert RadiusApiWeb.ErrorJSON.render("404.json", %{}) == %{
             error: %{
               status: "not_found",
               reason: "requested resource wasn't found"
             }
           }
  end

  test "renders 500" do
    assert RadiusApiWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end

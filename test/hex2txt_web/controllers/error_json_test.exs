defmodule Hex2txtWeb.ErrorJSONTest do
  use Hex2txtWeb.ConnCase, async: true

  test "renders 404" do
    assert Hex2txtWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Hex2txtWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end

defmodule Hex2txtWeb.PageController do
  use Hex2txtWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def llms_txt(conn, %{"package" => package} = params) do
    text(conn, Hex2txt.Generator.generate(package, Map.get(params, "version")))
  end
end

defmodule Hex2txt.HexScraper do
  @hexpm "https://hex.pm"
  @hexdocs "https://hexdocs.pm"

  def get_package_description!("elixir") do
    "Elixir is a dynamic, functional language for building scalable and maintainable applications."
  end

  def get_package_description!(package_name) do
    req = Req.new() |> ReqEasyHTML.attach()

    Req.get!(req, url: hexpm_package_url(package_name)).body[
      "meta[name=\"description\"]"
    ]
    |> Map.get(:nodes)
    |> Floki.attribute("content")
    |> List.first()
  end

  def get_search_data!(package_name, package_version \\ nil) do
    get!(package_name, package_version, "script[src^=\"dist/search_data-\"]", "searchData")
  end

  def get_sidebar_items!(package_name, package_version \\ nil) do
    get!(package_name, package_version, "script[src^=\"dist/sidebar_items-\"]", "sidebarNodes")
  end

  defp get!(package_name, package_version, selector, js_var) do
    find_json_url!(package_name, package_version, selector)
    |> decode_json!(js_var)
  end

  defp find_json_url!(package_name, package_version, selector) do
    req = Req.new() |> ReqEasyHTML.attach()

    src =
      Req.get!(req, url: hexdocs_asset_url("search.html", package_name, package_version)).body[
        selector
      ]
      |> Map.get(:nodes)
      |> Floki.attribute("src")
      |> List.first()

    hexdocs_asset_url(src, package_name, package_version)
  end

  defp decode_json!(url, js_var) do
    req = Req.new()

    Req.get!(req, url: url).body
    |> String.trim_leading("#{js_var}=")
    |> Jason.decode!()
  end

  defp hexpm_package_url(package_name) do
    "#{@hexpm}/packages/#{package_name}"
  end

  defp hexdocs_asset_url(src, package_name, nil) do
    "#{@hexdocs}/#{package_name}/#{src}"
  end

  defp hexdocs_asset_url(src, package_name, package_version) do
    "#{@hexdocs}/#{package_name}/#{package_version}/#{src}"
  end
end

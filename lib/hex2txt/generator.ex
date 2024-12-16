defmodule Hex2txt.Generator do
  alias Hex2txt.HexScraper

  def generate(package_name, package_version \\ nil) do
    title =
      "# " <>
        if package_version do
          "#{package_name} v#{package_version}"
        else
          package_name
        end

    description =
      HexScraper.get_package_description!(package_name)
      |> String.trim()
      |> String.split("\n", trim: false)
      |> Enum.map(&"> #{&1}")
      |> Enum.join("\n")

    search_data = HexScraper.get_search_data!(package_name, package_version)

    docs =
      search_data["items"]
      |> Enum.filter(
        &(&1["type"] in [
            "module",
            "type",
            "function",
            "protocol",
            "behaviour",
            "callback",
            "macro"
          ])
      )
      |> Enum.map(fn item ->
        "### #{item["title"]} (#{item["type"]})\n\n#{item["doc"]}"
      end)
      |> Enum.join("\n\n")

    [
      title,
      description,
      "## Docs",
      docs,
      "## Links",
      "- [Online documentation](https://hexdocs.pm/#{package_name})"
    ]
    |> Enum.join("\n\n")
  end
end

defmodule Hex2txtWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use Hex2txtWeb, :html

  embed_templates "page_html/*"
end

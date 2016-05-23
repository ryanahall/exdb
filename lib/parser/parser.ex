defmodule Parser do
  require Logger

  def parse(tokens) do
    tokens
    |> :exdb_parser.parse
  end
end

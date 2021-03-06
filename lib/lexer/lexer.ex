defmodule Lexer do
  require Logger

  def tokenize(query_string) do
    query_string
    |> String.to_char_list
    |> :exdb_lexer.string
  end

  def parse(tokens) do
    tokens
    |> :exdb_parser.parse
  end
end

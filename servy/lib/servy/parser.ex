defmodule Servy.Parser do

  alias Servy.Conv

  def parse(request) do
    [top, params_string] = String.split(request, "\r\n\r\n")

    [request_line | header_lines] = String.split(top, "\r\n")

    [method, path, _] = String.split(request_line, " ")

    headers = parse_headers(header_lines)

    params = parse_params(headers["Content-Type"], params_string)

    %Conv{
      method: method,
      path: path,
      params: params
    }
  end

  defp parse_headers(header_lines) do
    header_lines
    |> Enum.reduce(%{}, fn (header_line, acc) ->
      [name, value] = String.split(header_line, ": ")
      Map.put(acc, name, value)
    end)
  end

  defp parse_params("application/x-www-form-urlencoded", params_string) do
    params_string
    |> String.trim
    |> URI.decode_query
  end

  defp parse_params(_content_type, _params_string), do: %{}
end
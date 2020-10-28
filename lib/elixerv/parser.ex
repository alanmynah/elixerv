defmodule Elixerv.Parser do

  alias Elixerv.Conv

  def parse(request) do
    [headers | body] = request
                       |> String.split("\n\n")

    [request_line | request_headers] = headers
                                       |> String.split("\n")
    [method, path_with_query, _] = request_line
                                   |> String.split(" ")
    [path, query_params] = path_with_query
                           |> String.split("?")
    params_map = query_params
                 |> String.trim()
                 |> URI.decode_query()

    parsed_headers = parse_headers(request_headers, %{})

    %Conv{
      method: method
              |> String.trim(),
      path: path
            |> String.trim(),
      query_params: params_map,
      headers: parsed_headers,
      body: body
            |> List.first()
            |> String.trim(),
      resp_body: "",
      status_code: nil
    }
  end

  defp parse_headers([top | tail], headers) do
    [key, value] = top |> String.split(": ")
    headers = Map.put(headers, key, value)
    parse_headers(tail, headers)
  end

  defp parse_headers([], headers), do: headers

end

defmodule Elixerv.Parser do

  alias Elixerv.Conv

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %Conv{method: method, path: path, resp_body: "", status_code: nil}
  end

end
defmodule Elixerv.Plugins do

  alias Elixerv.Conv

  def track(%Conv{status_code: 404, path: path} = conv) do
    IO.puts("Warning: unmatched path #{path}")
    conv
  end

  def track(%Conv{} = conv), do: conv

  def log(%Conv{} = conv), do: IO.inspect(conv)

  def rewrite_path(%Conv{path: "/bears?id=" <> id} = conv) do
    %{conv | path: "/bears/#{id}}"}
  end

  def rewrite_path(%Conv{} = conv), do: conv
end

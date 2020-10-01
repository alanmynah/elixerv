defmodule Elixerv.FileHandler do

  alias Elixerv.Conv

  def handle_file({:ok, content}, %Conv{} = conv) do
    %Conv{conv | status_code: 200, resp_body: content}
  end

  def handle_file({:error, reason}, %Conv{} = conv) do
    %Conv{conv | status_code: 404, resp_body: "File error: #{reason}"}
  end
end

defmodule Elixerv.Handler do
  @moduledoc """
  Elixer+server=Elixerv (awful name) Handler module.

  To handle HTTP requests
  """
  import Elixerv.Parser
  import Elixerv.Plugins
  import Elixerv.FileHandler

  alias Elixerv.Conv

  # mix always runs from the root dir, and pages is there.
  @pages_path Path.expand("pages", File.cwd!())

  @doc """
  Converts HTTP request to a response
  """
  def handle(request) do
    request
    |> parse
    |> log
    |> rewrite_path
    |> route
    |> track
    |> format_response
  end

  def route(%Conv{method: "GET", path: "/about"} = conv) do
    get_page("about.html")
    |> handle_file(conv)
  end

  def route(%Conv{method: "GET", path: "/bears"} = conv) do
    %Conv{conv | status_code: 200, resp_body: "Paddington, Winnie the Pooh, Rupert"}
  end

  def route(%Conv{method: "POST", path: "/bears"} = conv) do
    %Conv{conv | status_code: 201, resp_body: "Created a #{conv.query_params["type"]} bear called #{conv.query_params["name"]}"}
  end

  def route(%Conv{method: "GET", path: "/bears/new"} = conv) do
    get_page("form.html")
    |> handle_file(conv)
  end

  def route(%Conv{method: "GET", path: "/bears/" <> id} = conv) do
    %Conv{conv | status_code: 200, resp_body: "Getting bear #{id}"}
  end

  def route(%Conv{method: "DELETE", path: "/bears/" <> _id} = conv) do
    %Conv{conv | status_code: 400, resp_body: "Bears must never be deleted!"}
  end

  def route(%Conv{method: "GET", path: "/pages/" <> file} = conv) do
    get_page(file <> ".html")
    |> handle_file(conv)
  end

  def route(%Conv{method: method, path: path} = conv) do
    %Conv{conv | status_code: 404, resp_body: "Either path #{path} not found or does not accept verb #{method}"}
  end

  def get_page(page_name) do
    @pages_path
    |> Path.join(page_name)
    |> File.read()
  end

  def format_response(%Conv{} = conv) do
    status_code = conv.status_code
    """
    HTTP/1.1 #{Conv.full_status(status_code)}
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end



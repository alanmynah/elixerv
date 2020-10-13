defmodule Elixerv.Conv do
  defstruct [
    method: "",
    path: "",
    query_params: %{},
    headers: %{},
    body: "",
    resp_body: "",
    status_code: nil
  ]

  def full_status(status_code) do
    "#{status_code} #{to_reason_phrase(status_code)}"
  end

  defp to_reason_phrase(code) do
    codes = %{
      200 => "OK",
      400 => "Bad Request",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }

    codes[code]
  end
end

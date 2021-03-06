defmodule Servy.Conv do

  alias Servy.Conv


  defstruct [
    method: "",
    path: "",
    resp_body: "",
    headers: %{},
    resp_content_type: "text/html",
    params: [],
    status: nil
  ]

  def full_status(%Conv{} = conv) do
    "#{conv.status} #{status_reason(conv.status)}"
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end
end
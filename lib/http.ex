defmodule Hypemex.HTTP do
  use HTTPoison.Base

  defp process_url(path) do
    Hypemex.api_url <> path
  end

  defp process_response_body(body) do
    body |> Poison.decode!
  end
end

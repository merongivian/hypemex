defmodule Hypemex do
  @url "https://api.hypem.com"
  @version "v2"

  def api_url do
    Enum.join [@url, @version, ""], "/"
  end
end

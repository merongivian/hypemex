defmodule Hypemex.Blogs do
  import Hypemex.HTTP, only: [get!: 1]
  @path "blogs"

  def collection, do: response!

  def obtain(attr), do: response!(attr)

  def subcollection(id, subpath) do
    response!([id, subpath])
  end

  defp response!(attrs) do
    ["" | List.wrap(attrs)]
    |> Enum.join("/")
    |> (&(get!(@path <> &1).body)).()
  end
  defp response!, do: get!(@path).body
end

defmodule Hypemex.Blogs do
  import Hypemex.HTTP, only: [get!: 1]
  @path "blogs"

  def collection do
    response!
  end

  def obtain(attr) do
    response!(attr)
  end

  def find(id) when is_number(id), do: response!(id)
  def find(id) when is_bitstring(id) do
    Enum.find collection, fn blog ->
      blog
      |> Map.get("sitename")
      |> String.downcase
      |> (&(&1 == id)).()
    end
  end

  def subcollection(entity, subpath) do
    case entity do
      %{"siteid" => site_id} -> response!([site_id, subpath])
      id -> response!([id, subpath])
    end
  end

  defp response!(attrs) do
    ["" | List.wrap(attrs)]
    |> Enum.join("/")
    |> (&(get!(@path <> &1).body)).()
  end
  defp response!, do: get!(@path).body
end

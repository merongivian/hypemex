defmodule Hypemex.Endpoints do
  defmodule Base do

    @callback path() :: String.t

    defmacro __using__(_params) do
      quote do
        import Hypemex.HTTP, only: [get!: 1]
        @behaviour Hypemex.Endpoints.Base

        def collection, do: response!
        def collection(category), do: get!(category).body

        def obtain(attr), do: response!(attr)

        def subcollection(id, subpath) do
          response!([id, subpath])
        end

        defp response!(attrs) do
          ["" | List.wrap(attrs)]
          |> Enum.join("/")
          |> (&(get!(path <> &1).body)).()
        end
        defp response!, do: get!(path).body
      end
    end
  end

  defmodule Blogs do
    use Base
    def path, do: "blogs"
  end

  defmodule Tracks do
    use Base
    def path, do: "tracks"
  end

  defmodule Artists do
    use Base
    def path, do: "artists"
  end
end

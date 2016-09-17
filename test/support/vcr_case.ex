defmodule VcrCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use ExSpec, async: true
      use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
    end
  end

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end
end

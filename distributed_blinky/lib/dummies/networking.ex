if :prod != Mix.env do

  defmodule Nerves.Networking do
    @moduledoc false
    use GenServer

    def start(_,_) do
      GenServer.start __MODULE__, [], [name: :networking]
    end

    def setup(interface, opts \\ []) do
      GenServer.start_link(__MODULE__, {interface, opts}, [name: :ethernet])
    end

    def init(_args) do
      {:ok, []}
    end
  end

  defmodule Nerves.IO.Led do

    def set(_), do: :ok

  end

end

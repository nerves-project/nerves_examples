defmodule HelloNetwork do

  require Logger
  
  alias Nerves.IO.Ethernet

  def start(_type, _args) do
    {:ok, _} = Ethernet.setup :eth0
    {:ok, self}
  end

end
 
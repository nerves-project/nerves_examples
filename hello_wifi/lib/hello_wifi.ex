defmodule HelloWifi do

  def start(_type, _args) do
    opts = Application.get_env(:hello_wifi, :wlan0)
    Nerves.InterimWiFi.setup "wlan0", opts
    {:ok, self}
  end

end

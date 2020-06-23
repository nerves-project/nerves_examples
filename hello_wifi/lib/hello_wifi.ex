defmodule HelloWiFi do
  use Application

  require Logger

  @ifname "wlan0"

  @spec start(Application.start_type(), any()) :: {:error, any} | {:ok, pid()}
  def start(_type, _args) do
    maybe_start_wifi_wizard()

    gpio_pin = Application.get_env(:hello_wifi, :button_pin, 17)

    children = [
      {HelloWiFi.Button, gpio_pin}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: HelloWiFi.Supervisor)
  end

  @doc false
  def on_wizard_exit() do
    # This function is used as a callback when the WiFi Wizard
    # exits which is useful if you need to do work after
    # configuration is done, like restart web servers that might
    # share a port with the wizard, etc etc
    Logger.info("[HelloWiFi] - WiFi Wizard stopped")
  end

  defp maybe_start_wifi_wizard() do
    with true <- has_wifi?() || :no_wifi,
         true <- wifi_configured?() || :not_configured,
         true <- has_networks?() || :no_networks do
      # By this point we know there is a wlan interface available
      # and already configured with networks. This would normally
      # mean that you should then skip starting the WiFi wizard
      # here so that the device doesn't start the WiFi wizard after
      # every reboot.
      #
      # However, for the example we want to always run the
      # WiFi wizard on startup. Comment/remove the function below
      # if you want a more typical experience skipping the wizard
      # after it has been configured once.
      VintageNetWizard.run_wizard(on_exit: {__MODULE__, :on_wizard_exit, []})
    else
      :no_wifi ->
        Logger.error(
          "[#{inspect(__MODULE__)}] Device does not support WiFi - Skipping wizard start"
        )

      status ->
        info_message(status)
        VintageNetWizard.run_wizard(on_exit: {__MODULE__, :on_wizard_exit, []})
    end
  end

  defp has_wifi?() do
    @ifname in VintageNet.all_interfaces()
  end

  defp wifi_configured?() do
    @ifname in VintageNet.configured_interfaces()
  end

  defp has_networks?() do
    VintageNet.get_configuration(@ifname).vintage_net_wifi.networks != []
  end

  defp info_message(status) do
    msg =
      case status do
        :not_configured -> "WiFi has not been configured"
        :no_networks -> "WiFi was configured without any networks"
      end

    Logger.info("[#{inspect(__MODULE__)}] #{msg} - Starting WiFi Wizard")
  end
end

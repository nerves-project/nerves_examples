defmodule HelloDistribution.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @ifname "wlan0"

  def start(_type, _args) do
    maybe_start_wifi_wizard()
    maybe_start_distribution()
    opts = [strategy: :one_for_one, name: HelloDistribution.Supervisor]
    gpio_pin = Application.get_env(:hello_distribution, :button_pin, 17)

    children = [
      {HelloDistribution.Button, gpio_pin},
      {Phoenix.PubSub, name: HelloDistribution.PubSub}
    ]

    Supervisor.start_link(children, opts)
  end

  @doc false
  def on_wizard_exit() do
    # This function is used as a callback when the WiFi Wizard
    # exits which is useful if you need to do work after
    # configuration is done, like restart web servers that might
    # share a port with the wizard, etc etc
    Logger.info("[#{inspect(__MODULE__)}] - WiFi Wizard stopped")
  end

  def maybe_start_distribution() do
    _ = :os.cmd('epmd -daemon')
    {:ok, hostname} = :inet.gethostname()

    case Node.start(:"hello@#{hostname}.local") do
      {:ok, _pid} -> Logger.info("Distribution started at hello@#{hostname}.local")
      _error -> Logger.error("Failed to start distribution")
    end
  end

  def maybe_start_wifi_wizard() do
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

  def has_wifi?() do
    @ifname in VintageNet.all_interfaces()
  end

  def wifi_configured?() do
    @ifname in VintageNet.configured_interfaces()
  end

  def has_networks?() do
    VintageNet.get_configuration(@ifname)[:vintage_net_wifi][:networks] != []
  end

  def info_message(status) do
    msg =
      case status do
        :not_configured -> "WiFi has not been configured"
        :no_networks -> "WiFi was configured without any networks"
      end

    Logger.info("[#{inspect(__MODULE__)}] #{msg} - Starting WiFi Wizard")
  end

  def target() do
    Application.get_env(:hello_distribution, :target)
  end
end

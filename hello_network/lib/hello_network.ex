defmodule HelloNetwork do

  alias Nerves.Networking

  @interface :eth0

  def start(_type, _args) do
    unless :os.type == {:unix, :darwin} do     # don't start networking unless we're on nerves
      {:ok, _} = Networking.setup @interface
    end
    {:ok, self()}
  end

  @doc "Attempts to perform a DNS lookup to test connectivity."
  def test_dns(hostname \\ 'nerves-project.org') do
    :inet_res.gethostbyname(hostname)
  end
end

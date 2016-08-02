defmodule HelloNetwork do

  alias Nerves.Networking
  alias Nerves.SSDPServer
  alias Nerves.Lib.UUID

  @interface :eth0

  def start(_type, _args) do
    unless :os.type == {:unix, :darwin} do     # don't start networking unless we're on nerves
      {:ok, _} = Networking.setup @interface
    end
    #publish_node_via_ssdp(@interface)
    {:ok, self}
  end

  # define SSDP service type that allows discovery from the cell tool,
  # so a node running this example can be found with `cell list`
  defp publish_node_via_ssdp(_iface) do
    usn = "uuid:" <> UUID.generate
    st = "urn:nerves-project-org:service:cell:1"
    #fields = ["x-node": (node |> to_string) ]
    {:ok, _} = SSDPServer.publish usn, st
  end

  @doc "Attempts to perform a DNS lookup to test connectivity."
  def test_dns(hostname \\ 'nerves-project.org') do
    :inet_res.gethostbyname(hostname)
  end
end

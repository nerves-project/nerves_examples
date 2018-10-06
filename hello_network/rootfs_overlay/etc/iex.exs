# Pull in Nerves-specific helpers to the IEx session
use Nerves.Runtime.Helpers

if RingLogger in Application.get_env(:logger, :backends, []) do
  IO.puts """
  RingLogger is collecting log messages from Elixir and Linux. To see the
  messages, either attach the current IEx session to the logger:

    RingLogger.attach

  or tail the log:

    RingLogger.tail
  """
end

# Be careful when adding to this file. Nearly any error can crash the VM and
# cause a reboot.

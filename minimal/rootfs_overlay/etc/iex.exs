IO.puts("""
\e[34m████▄▖    \e[36m▐███
\e[34m█▌  ▀▜█▙▄▖  \e[36m▐█
\e[34m█▌ \e[36m▐█▄▖\e[34m▝▀█▌ \e[36m▐█   \e[39mN  E  R  V  E  S
\e[34m█▌   \e[36m▝▀█▙▄▖ ▐█
\e[34m███▌    \e[36m▀▜████\e[0m
""")

# Add Toolshed helpers to the IEx session
use Toolshed

if RingLogger in Application.get_env(:logger, :backends, []) do
  IO.puts("""
  RingLogger is collecting log messages from Elixir and Linux. To see the
  messages, either attach the current IEx session to the logger:

    RingLogger.attach

  or print the next messages in the log:

    RingLogger.next
  """)
end

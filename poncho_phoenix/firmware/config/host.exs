import Config

# Add configuration that is only needed when running on the host here.

config :ui, Ui.Repo,
  database: Path.expand("../ui_dev.db", Path.dirname(__ENV__.file)),
  pool_size: 5,
  show_sensitive_data_on_connection_error: true

import_config "../../ui/config/config.exs"

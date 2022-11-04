# Used by "mix format"
[
  import_deps: [:ecto, :phoenix],
  inputs: [
    "*.{ex,exs}",
    "{config,lib,test}/**/*.{ex,exs}",
    "rootfs_overlay/etc/iex.exs"
  ],
  subdirectories: ["priv/*/migrations"]
]

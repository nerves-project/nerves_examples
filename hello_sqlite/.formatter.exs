# Used by "mix format"
[
  import_deps: [:ecto],
  inputs: [
    "*.{ex,exs}",
    "priv/*/seeds.exs",
    "{config,lib,test}/**/*.{ex,exs}",
    "rootfs_overlay/etc/iex.exs"
  ],
  subdirectories: ["priv/*/migrations"]
]

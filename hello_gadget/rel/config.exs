use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: :dev

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set cookie: :"N7=;||Lz5e!U{m:{N=@RkF*8pj)3(sPxuINmfs[@xV[uQAg!Gbsx%ka`7c7V[WBz"
end

environment :prod do
  set cookie: :"N7=;||Lz5e!U{m:{N=@RkF*8pj)3(sPxuINmfs[@xV[uQAg!Gbsx%ka`7c7V[WBz"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :hello_gadget do
  set version: current_version(:hello_gadget)
  plugin Bootloader.Plugin
  if System.get_env("NERVES_SYSTEM") do
    set dev_mode: false
    set include_src: false
    set include_erts: System.get_env("ERL_LIB_DIR")
    set include_system_libs: System.get_env("ERL_SYSTEM_LIB_DIR")
    set vm_args: "rel/vm.args"
  end
end


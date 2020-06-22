defmodule HelloZig do

  use Zigler

  ~Z"""
  const world = @import("strings.zig").world;

  /// outputs "world" for hello!
  /// nif: hello/0
  fn hello(env: beam.env) beam.term {
    return beam.make_atom(env, world);
  }
  """

end

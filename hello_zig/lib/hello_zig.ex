defmodule HelloZig do
  use Zig, otp_app: :hello_zig

  ~Z"""
  const beam = @import("beam");
  const strings = @import("strings.zig");

  pub fn hello() beam.term {
    return beam.make(.{.ok, strings.world}, .{});
  }
  """
end

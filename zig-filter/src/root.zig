//! By convention, root.zig is the root source file when making a library.
const std = @import("std");
pub const c = @import("c.zig").defaultImport;

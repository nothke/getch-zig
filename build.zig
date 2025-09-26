const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const mod = b.addModule("getch", .{
        .root_source_file = b.path("src/getch.zig"),
        .target = target,
    });

    _ = b.addLibrary(.{
        .root_module = mod,
        .name = "getch",
        .zig_lib_dir = b.path("src"),
    });
}

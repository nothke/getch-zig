### getch()

`getch()` is a function that reads a single character from the keyboard in the terminal without waiting for the user to press Enter. This allows the terminal to update on every key press, useful when making terminal-based games or interactive TUIs.

This is a cross-platform implementation of the function in Zig. For now it has been tested on Windows and Linux.

### How to use

Either copy `getch.zig` and just `const getch = @import("getch.zig");` to your repo, or add this repo as a package:

```zig
zig fetch --save git+[URL to this repo].git
```

Then add an import to your module and link lib C to build.zig:

```zig
exe.root_module.addImport("getch", b.dependency("getch", .{}).module("getch"));
exe.linkLibC();
```

Then in your code:

```zig
const getch = @import("getch");

fn main() void {
    const char = try getch.getch();
    std.log.info("You typed char: {c}, code: {}", .{char, char});
}

```
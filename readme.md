### getch()

getch() is a function that reads a single character from the keyboard without waiting for the user to press Enter.

This is a cross-platform implementation (for now it works on Windows and Linux).

### How to use

Either copy `getch.zig` to your repo, or add this as a package:

```zig
zig fetch --save git+[URL to this repo].git
```

To build.zig add an import to your module:

```zig
.imports = &.{
    {
        .name = "getch",
        .module = b.dependency("getch", .{ .target = target }).module("getch"),
    },
```

Then in your code:

```zig
const getch = @import("getch");

fn main() void {
    const char = try getch.getch();
}

```
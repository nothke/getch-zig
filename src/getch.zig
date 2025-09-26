const std = @import("std");
const builtin = @import("builtin");

// Get a keypress. This works for Linux.
// Source: https://viewsourcecode.org/snaptoken/kilo/02.enteringRawMode.html
fn getchLinux() !u8 {
    var stdin_buffer = std.mem.zeroes([1024]u8);
    var stdin_reader = std.fs.File.stdin().reader(&stdin_buffer);
    const stdin = &stdin_reader.interface;

    const c = @cImport({
        @cInclude("termios.h");
        @cInclude("unistd.h");
    });

    // save current mode
    var orig_termios: c.termios = undefined;
    _ = c.tcgetattr(c.STDIN_FILENO, &orig_termios);

    // set new "raw" mode
    var raw = orig_termios;
    raw.c_lflag &= @bitCast(~(c.ECHO | c.ICANON | c.ISIG));
    _ = c.tcsetattr(c.STDIN_FILENO, c.TCSAFLUSH, &raw);

    var shortBuffer: [1]u8 = undefined;
    _ = try stdin.readSliceShort(&shortBuffer);
    const char = shortBuffer[0];

    // restore old mode
    _ = c.tcsetattr(c.STDIN_FILENO, c.TCSAFLUSH, &orig_termios);
    return char;
}

// Get a keypress. This works for Windows.
fn getchWin() !u8 {
    const c = @cImport({
        @cInclude("conio.h");
    });

    const char = c.getch();
    return @as(u8, @truncate(@as(u32, @bitCast(char))));
}

pub const getch = if (builtin.os.tag == .windows)
    getchWin
else
    getchLinux;

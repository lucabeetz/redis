const std = @import("std");
const net = std.net;
const os = std.os;

fn do_something(conn: net.StreamServer.Connection) !void {
    var buf: [1024]u8 = undefined;
    const msg_size = try conn.stream.read(&buf);
    _ = try conn.stream.write("world");
    std.log.info("Received: {s}", .{buf[0..msg_size]});
}

pub fn main() !void {
    const self_addr = net.Address.initIp4([_]u8{ 127, 0, 0, 1 }, 9000);
    var listener = net.StreamServer.init(.{ .reuse_address = true });
    try listener.listen(self_addr);

    // const conn = try listener.accept();
    while (true) {
        const conn = try listener.accept();
        try do_something(conn);
    }
}

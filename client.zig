const std = @import("std");
const net = std.net;
const os = std.os;

pub fn main() !void {
    const server_addr = net.Address.initIp4([_]u8{ 127, 0, 0, 1 }, 9000);
    const stream = try net.tcpConnectToAddress(server_addr);

    const msg = "hello";
    _ = try stream.write(msg);
    std.log.info("Sent message: {s}", .{msg});

    var buf: [1024]u8 = undefined;
    const n = try stream.read(&buf);
    std.log.info("Received message: {s}", .{buf[0..n]});
}

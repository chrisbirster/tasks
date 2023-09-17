const std = @import("std");

const tasks = std.ArrayList([]const u8).init(std.heap.page_allocator);

/// A Task is an object that represents a task to be completed.
const Task = struct {
    // The name of the task.
    name: []const u8,
    // The description of the task.
    description: []const u8,
    // Whether or not the task is complete.
    complete: bool,
};

/// TaskTops is an enum that represents the different operations that can
/// be performed on a task.
const TaskOpts = enum {
    // Add a task to the queue.
    add,
    // Remove a task from the queue.
    remove,
    // Mark a task as completed.
    complete,
    // List all tasks in the queue.
    list,
};

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();
    var args_it = try std.process.ArgIterator.initWithAllocator(allocator);
    defer args_it.deinit();

    // skip the exe name
    _ = args_it.skip();

    // no args, show help
    const command_name = args_it.next() orelse show_main_help();

    // unknown arg, show help
    const command = std.meta.stringToEnum(TaskOpts, command_name) orelse show_main_help();

    // parse arg
    switch (command) {
        .add => {
            std.debug.print("add called\n", .{});
        },
        .remove => {
            std.debug.print("remove called\n", .{});
        },
        .complete => {
            std.debug.print("complete called\n", .{});
        },
        .list => {
            std.debug.print("list called\n", .{});
        },
    }
}

fn show_main_help() noreturn {
    std.debug.print("{s}\n", .{
        \\Usage: ztask <command>
        \\Commands:
        \\    add <name> <description>
        \\    remove <name>
        \\    complete <name>
        \\    list
        \\    help
        \\    version
        \\
    });
    std.process.exit(0);
}

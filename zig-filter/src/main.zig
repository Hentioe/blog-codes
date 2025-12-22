const std = @import("std");
const zig_filter = @import("zig_filter");
const c = zig_filter.c;

pub fn main() !void {
    // 打开 PNG 图片文件
    const f = c.fopen("parrot.png", "r");
    if (f == null) {
        @panic("failed to open parrot.png\n");
    }
    defer if (c.fclose(f) != c.SPNG_OK) {
        @panic("failed to close parrot.png\n");
    };

    // 创建 SPNG 上下文
    const ctx = c.spng_ctx_new(0) orelse {
        @panic("failed to create spng context\n");
    };
    defer c.spng_ctx_free(ctx);
    // 设置 PNG 文件
    _ = c.spng_set_png_file(ctx, f);

    // 读取 PNG 头信息
    var header: c.spng_ihdr = undefined;
    if (c.spng_get_ihdr(ctx, &header) != c.SPNG_OK) {
        @panic("failed to get PNG header\n");
    }

    // 获取解码后的图像大小
    var size: u64 = 0;
    if (c.spng_decoded_image_size(ctx, c.SPNG_FMT_RGBA8, &size) != c.SPNG_OK) {
        @panic("failed to get decoded image size\n");
    } else {
        std.debug.print("decoded image size: {d} bytes\n", .{size});
    }
    // 创建缓冲区并解码图像
    const allocator = std.heap.page_allocator;
    const buffer = try allocator.alloc(u8, size);
    defer allocator.free(buffer);
    @memset(buffer[0..], 0);
    if (c.spng_decode_image(ctx, buffer.ptr, buffer.len, c.SPNG_FMT_RGBA8, 0) != c.SPNG_OK) {
        @panic("failed to decode image\n");
    }

    // 应用灰度滤镜
    const len = buffer.len;
    const weight_r: f16 = 0.299;
    const weight_g: f16 = 0.587;
    const weight_b: f16 = 0.114;
    var i: u64 = 0;
    while (i < len) : (i += 4) {
        const r: f16 = @floatFromInt(buffer[i]);
        const g: f16 = @floatFromInt(buffer[i + 1]);
        const b: f16 = @floatFromInt(buffer[i + 2]);
        // 使用加权平均法计算灰度值
        const gray: f16 = r * weight_r + g * weight_g + b * weight_b;
        buffer[i] = @intFromFloat(gray);
        buffer[i + 1] = @intFromFloat(gray);
        buffer[i + 2] = @intFromFloat(gray);
        buffer[i + 3] = buffer[i + 3]; // Alpha 通道保持不变
    }

    // 编码到输出图片
    const out = c.fopen("parrot-grayscale.png", "wb");
    if (out == null) {
        @panic("failed to open parrot-grayscale.png\n");
    }
    defer if (c.fclose(out) != c.SPNG_OK) {
        @panic("failed to close parrot-grayscale.png\n");
    };
    // 创建输出 SPNG 上下文
    const out_ctx = c.spng_ctx_new(c.SPNG_CTX_ENCODER) orelse {
        @panic("failed to create output spng context\n");
    };
    defer c.spng_ctx_free(out_ctx);
    // 设置输出 PNG 文件和头信息
    if (c.spng_set_png_file(out_ctx, out) != c.SPNG_OK) {
        @panic("failed to set output PNG file\n");
    }
    if (c.spng_set_ihdr(out_ctx, &header) != c.SPNG_OK) {
        @panic("failed to set output PNG header\n");
    }
    // 编码图像到输出文件
    const r = c.spng_encode_image(
        out_ctx,
        buffer.ptr,
        buffer.len,
        c.SPNG_FMT_RGBA8, // <- 这里我故意传递了错误参数
        c.SPNG_ENCODE_FINALIZE,
    );
    if (r != c.SPNG_OK) {
        printSpngError(r);
        @panic("failed to encode image\n");
    }
}

fn printSpngError(code: c_int) void {
    const err = c.spng_strerror(code);
    std.debug.print("libspng error: {s}\n", .{err});
}

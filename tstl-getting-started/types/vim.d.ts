/**
 * @noSelf
 */
declare namespace NvimAPI {
  /**
   * 获取指定缓冲区的文件名。
   *
   * @param buf 要查询的缓冲区句柄或 ID。0 表示当前缓冲区。
   * @returns 缓冲区的文件名字符串。如果缓冲区没有关联文件，可能返回空字符串。
   */
  function nvim_buf_get_name(buf: number): string;
}

/**
 * @noResolution
 */
declare module "vim" { // 假设在 TypeScript 中你会导入 "vim" 模块
  const vim: {
    api: typeof NvimAPI
  }

  export default vim
}

declare global {
  const vim: {
    api: typeof NvimAPI;
  };
}

export { };
with import <nixpkgs> { };

mkShell {
  buildInputs = [ cmake ];
  LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
}

with import <nixpkgs> { };

mkShell {
  buildInputs = [
    pkg-config
    openssl # alidns-tester
    q # alidns-tester
  ];
  LD_LIBRARY_PATH = lib.makeLibraryPath [
    openssl # alidns-tester
  ];
}

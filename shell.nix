with import <nixpkgs> { };

mkShell {
  buildInputs = [
    pkg-config
    cmake # pingora-quick-start
    openssl # alidns-tester
    q # alidns-tester
  ];
  LD_LIBRARY_PATH = lib.makeLibraryPath [
    openssl # alidns-tester
  ];
}

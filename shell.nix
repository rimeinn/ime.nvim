{ pkgs ? import <nixpkgs> { } }:

with pkgs;
mkShell {
  name = "shm";
  buildInputs = [
    gobject-introspection
    pkg-config
  ];
}

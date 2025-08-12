{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;
mkShell {
  name = "ime.nvim";
  buildInputs = [
    gobject-introspection
    pkg-config

    (luajit.withPackages (
      p: with p; [
        busted
        ldoc
      ]
    ))
  ];
}

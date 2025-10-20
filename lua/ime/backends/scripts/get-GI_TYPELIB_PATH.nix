#!/usr/bin/env -S nix eval --impure -f
let
  pkgs = import <nixpkgs> { };
in
let
  suffix = "lib/girepository-1.0";
in
"${pkgs.glib.out}/${suffix}:${pkgs.gobject-introspection}/${suffix}:${pkgs.gobject-introspection.unwrapped}/${suffix}"

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=5e4fbfb6b3de1aa2872b76d49fafc942626e2add";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = with pkgs; mkShell {
          buildInputs = [
            gleam
            erlang
            rebar3
            just
            watchexec
          ];
        };
      });
}


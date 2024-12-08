{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=345c263f2f53a3710abe117f28a5cb86d0ba4059";
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


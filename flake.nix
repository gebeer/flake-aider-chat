{
  description = "My Python Flake Shells";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells = {
        x86_64-linux = pkgs.mkShell {
          buildInputs = with pkgs; [
            (pkgs.python311Full.withPackages (ps: with ps; [ virtualenv pip setuptools wheel ]))
          ];
        };
      };
    };
}

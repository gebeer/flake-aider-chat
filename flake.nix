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
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          (pkgs.python3.withPackages (ps: with ps; [ virtualenv pip setuptools wheel ]))
        ];
        shellHook = ''
          if [ ! -d .venv ]; then
            virtualenv .venv
          fi
          source .venv/bin/activate
          pip install --upgrade aider-chat --prefix=$PWD/.venv
          export PATH=$PWD/.venv/bin:$PATH
        '';
        exitHook = ''
          deactivate
        '';
      };
    };
}
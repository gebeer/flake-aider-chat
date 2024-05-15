{
  description = "Flake providing dev shell for using aider-chat in NixOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in
    {
      url = self.sourceInfo.url;
      
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              (pkgs.python3.withPackages (ps: with ps; [ virtualenv pip setuptools wheel ]))
            ];
            # set LD_LIBRARY_PATH environment variable to avoid error. see https://discourse.nixos.org/t/how-to-solve-libstdc-not-found-in-shell-nix/25458
            LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib";
            shellHook = ''
              # create virtualenv if not exist
              if [ ! -d .venv ]; then
                virtualenv .venv
              fi
              # activate virtualenv
              source .venv/bin/activate
              # install aider-chat into virtualenv and upgrade it
              pip install --upgrade aider-chat --prefix=$PWD/.venv
              # export PATH to virtualenv bins
              export PATH=$PWD/.venv/bin:$PATH
            '';
            exitHook = ''
              deactivate
            '';
          };
        }
      );
    };
}
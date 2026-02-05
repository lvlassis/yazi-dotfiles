{
  description = "Smart-filter flakes";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in {
      packages = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          # renomeie "my-plugin" pro nome do seu plugin
          smart-filter = pkgs.stdenv.mkDerivation {
            pname = "smart-filter";
            version = "0.1.0";
            src = ./.;

            dontBuild = true;
            # Copia tudo que compõe o plugin para a raiz do $out
            installPhase = ''
              mkdir -p $out
              cp -r ./* $out/
            '';

            meta = with pkgs.lib; {
              description = "My fork from smart-filter";
              homepage = "https://github.com/Sevenings/smart-filter.yazi";
              license = licenses.mit;
              platforms = platforms.all;
            };
          };

          # pacote padrão opcional
          default = self.packages.${system}.smart-filter;
        });

      # opcional: expõe via overlay em pkgs.yaziPlugins.my-plugin
      overlays.default = final: prev: {
        yaziPlugins = (prev.yaziPlugins or { }) // {
          smart-filter = self.packages.${final.stdenv.hostPlatform.system}.smart-filter;
        };
      };
    };
}


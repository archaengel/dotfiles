{
  description = "A flake of archaengel's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    plugins-nvim-navic = {
      url = "github:SmiteshP/nvim-navic";
      flake = false;
    };

    plugins-gh-nvim = {
      url = "github:ldelossa/gh.nvim";
      flake = false;
    };

    plugins-nerdcommenter = {
      url = "github:preservim/nerdcommenter";
      flake = false;
    };

    plugins-nvim-dap-vscode-js = {
      url = "github:mxsdev/nvim-dap-vscode-js";
      flake = false;
    };

    plugins-vscode-js-debug = {
      url = "github:microsoft/vscode-js-debug";
      flake = false;
    };
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
        "x86_64-darwin"
      ];

      customNvim = import ./nvim/.config/nvim/default.nix { inherit inputs; };
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.stdenv.mkDerivation {
            name = "dotfiles";
            src = ./.;

            installPhase = ''
              mkdir -p $out
              cp -r $src/* $out
            '';
          };

	  nvim = customNvim.packages.${system}.nvim;
        }
      );
    };
}

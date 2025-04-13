# Copyright (c) 2023 BirdeeHub
# Licensed under the MIT license
/*
  # paste the inputs you don't have in this set into your main system flake.nix
  # (lazy.nvim wrapper only works on unstable)
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  Then call this file with:
  myNixCats = import ./path/to/this/dir { inherit inputs; };
  And the new variable myNixCats will contain all outputs of the normal flake format.
  You could put myNixCats.packages.${pkgs.system}.thepackagename in your packages list.
  You could install them with the module and reconfigure them too if you want.
  You should definitely re export them under packages.${system}.packagenames
  from your system flake so that you can still run it via nix run from anywhere.

  The following is just the outputs function from the flake template.
*/
{ inputs, ... }@attrs:
let
  inherit (inputs) nixpkgs; # <-- nixpkgs = inputs.nixpkgsSomething;
  inherit (inputs.nixCats) utils;
  luaPath = "${./.}";
  forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
  # the following extra_pkg_config contains any values
  # which you want to pass to the config set of nixpkgs
  # import nixpkgs { config = extra_pkg_config; inherit system; }
  extra_pkg_config = {
    # allowUnfree = true;
  };
  dependencyOverlays = # (import ./overlays inputs) ++
    [
      # see :help nixCats.flake.outputs.overlays
      # This overlay grabs all the inputs named in the format
      # `plugins-<pluginName>`
      # Once we add this overlay to our nixpkgs, we are able to
      # use `pkgs.neovimPlugins`, which is a set of our plugins.
      (utils.standardPluginOverlay inputs)
      # add any flake overlays here.

      # when other people mess up their overlays by wrapping them with system,
      # you may instead call this function on their overlay.
      # it will check if it has the system in the set, and if so return the desired overlay
      # (utils.fixSystemizedOverlay inputs.codeium.overlays
      #   (system: inputs.codeium.overlays.${system}.default)
      # )
    ];

  categoryDefinitions =
    {
      pkgs,
      settings,
      categories,
      extra,
      name,
      mkPlugin,
      ...
    }@packageDef:
    {

      lspsAndRuntimeDeps = {
        general = with pkgs; [
          haskell-language-server
          typescript-language-server
          terraform-lsp
          nixd
          efm-langserver
          ripgrep
          fzf
          lua-language-server
        ];

        debug = with pkgs; [
          vscode-js-debug
        ];

        latex = with pkgs; [
          zathura
        ];
      };

      startupPlugins = {
        general = with pkgs; [
          vimPlugins.lze
          vimPlugins.litee-nvim
          vimPlugins.nvim-web-devicons
          vimPlugins.nvim-lspconfig
          vimPlugins.plenary-nvim
          vimPlugins.nvim-treesitter.withAllGrammars
          vimPlugins.zen-mode-nvim
          vimPlugins.vimtex
          vimPlugins.which-key-nvim
          vimPlugins.telescope-nvim
          vimPlugins.telescope-ui-select-nvim
          vimPlugins.telescope-fzf-native-nvim
          vimPlugins.telescope-symbols-nvim
          vimPlugins.impatient-nvim
          vimPlugins.markdown-preview-nvim
          vimPlugins.galaxyline-nvim
          vimPlugins.gitsigns-nvim
          neovimPlugins.gh-nvim

          vimPlugins.tokyonight-nvim
          neovimPlugins.nerdcommenter

          vimPlugins.harpoon
          vimPlugins.nvim-autopairs

          neovimPlugins.nvim-navic

          vimPlugins.rest-nvim

          # cmp
          vimPlugins.nvim-cmp
          vimPlugins.cmp-buffer
          vimPlugins.cmp-path
          vimPlugins.luasnip
          vimPlugins.cmp_luasnip
          vimPlugins.cmp-nvim-lsp

          # TODO: consider copilot

          vimPlugins.gitlinker-nvim
          vimPlugins.vim-dadbod
          vimPlugins.vim-dadbod-ui

          vimPlugins.neo-tree-nvim
          vimPlugins.nvterm
        ];

        lsp = with pkgs; [
          vimPlugins.lspkind-nvim
          vimPlugins.fidget-nvim
          vimPlugins.nvim-metals
        ];

        debug = with pkgs; [
          vimPlugins.nvim-dap
          neovimPlugins.nvim-dap-vscode-js
        ];
      };

      optionalPlugins = {
        gitPlugins = with pkgs.neovimPlugins; [ ];
        general = with pkgs.vimPlugins; [ ];
      };

      # shared libraries to be added to LD_LIBRARY_PATH
      # variable available to nvim runtime
      sharedLibraries = {
        general = with pkgs; [
          # libgit2
        ];
      };

      environmentVariables = {
      };

      extraWrapperArgs = {
      };
    };

  packageDefinitions = {
    nvim =
      { pkgs, name, ... }:
      {
        # they contain a settings set defined above
        # see :help nixCats.flake.outputs.settings
        settings = {
          suffix-path = true;
          suffix-LD = true;
          wrapRc = true;
          aliases = [ "vim" ];
          neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
        };
        # and a set of categories that you want
        # (and other information to pass to lua)
        categories = {
          general = true;
          debug = true;
          lsp = true;
          latex = true;
        };
        extra = { };
      };
  };
  # In this section, the main thing you will need to do is change the default package name
  # to the name of the packageDefinitions entry you wish to use as the default.
  defaultPackageName = "nvim";
in
# see :help nixCats.flake.outputs.exports
forEachSystem (
  system:
  let
    nixCatsBuilder = utils.baseBuilder luaPath {
      inherit
        system
        dependencyOverlays
        extra_pkg_config
        nixpkgs
        ;
    } categoryDefinitions packageDefinitions;
    defaultPackage = nixCatsBuilder defaultPackageName;
    # this is just for using utils such as pkgs.mkShell
    # The one used to build neovim is resolved inside the builder
    # and is passed to our categoryDefinitions and packageDefinitions
    pkgs = import nixpkgs { inherit system; };
  in
  {
    # this will make a package out of each of the packageDefinitions defined above
    # and set the default package to the one passed in here.
    packages = utils.mkAllWithDefault defaultPackage;

    # choose your package for devShell
    # and add whatever else you want in it.
    devShells = {
      default = pkgs.mkShell {
        name = defaultPackageName;
        packages = [ defaultPackage ];
        inputsFrom = [ ];
        shellHook = '''';
      };
    };

  }
)
// (
  let
    # we also export a nixos module to allow reconfiguration from configuration.nix
    nixosModule = utils.mkNixosModules {
      moduleNamespace = [ defaultPackageName ];
      inherit
        defaultPackageName
        dependencyOverlays
        luaPath
        categoryDefinitions
        packageDefinitions
        extra_pkg_config
        nixpkgs
        ;
    };
    # and the same for home manager
    homeModule = utils.mkHomeModules {
      moduleNamespace = [ defaultPackageName ];
      inherit
        defaultPackageName
        dependencyOverlays
        luaPath
        categoryDefinitions
        packageDefinitions
        extra_pkg_config
        nixpkgs
        ;
    };
  in
  {

    # these outputs will be NOT wrapped with ${system}

    # this will make an overlay out of each of the packageDefinitions defined above
    # and set the default overlay to the one named here.
    overlays = utils.makeOverlays luaPath {
      # we pass in the things to make a pkgs variable to build nvim with later
      inherit nixpkgs dependencyOverlays extra_pkg_config;
      # and also our categoryDefinitions
    } categoryDefinitions packageDefinitions defaultPackageName;

    nixosModules.default = nixosModule;
    homeModules.default = homeModule;

    inherit utils nixosModule homeModule;
    inherit (utils) templates;
  }
)

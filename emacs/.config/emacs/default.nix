{
  lib,
  typescript-language-server,
  nixd,
  prettier,
  eslint_d,
  emacsPackagesFor,
  emacs-nox,
  symlinkJoin,
  makeWrapper,
}:
let
  binPath = lib.makeBinPath [
    typescript-language-server
    nixd
    prettier
    eslint_d
  ];
  emacsWrapped = (emacsPackagesFor emacs-nox).emacsWithPackages (
    epkgs: with epkgs; [
      ghostel
      tree-sitter
      treesit-grammars.with-all-grammars
      evil
      nix-mode
      doom-themes
      no-littering
    ]
  );
in
symlinkJoin {
  name = "emacs-wrapped";
  paths = [
    emacsWrapped
  ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    ls $out/bin
    wrapProgram $out/bin/emacs \
          --suffix PATH : "${binPath}"
  '';
  inherit (emacsWrapped) meta;
}

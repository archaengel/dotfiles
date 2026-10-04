{
  emacs-pgtk,
  emacsPackagesFor,
  eslint_d,
  initDir,
  jdt-language-server,
  lib,
  makeWrapper,
  nixd,
  prettier,
  symlinkJoin,
  typescript-language-server,
  zls,
}:
let
  binPath = lib.makeBinPath [
    jdt-language-server
    typescript-language-server
    nixd
    prettier
    eslint_d
    zls
  ];
  emacsUnwrapped = (emacsPackagesFor emacs-pgtk).emacsWithPackages (
    epkgs: with epkgs; [
      ghostel
      tree-sitter
      treesit-grammars.with-all-grammars
      evil
      nix-mode
      doom-themes
      no-littering
      markdown-ts-mode
      zig-ts-mode
      uxntal-mode
      exwm
    ]
  );
in
symlinkJoin {
  name = "emacs-wrapped";
  paths = [
    emacsUnwrapped
  ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    ls $out/bin
    wrapProgram $out/bin/emacs \
          --suffix PATH : "${binPath}" \
          --append-flags "--init-directory \$(if [[ -n \"\$NOWRAP_EMACS\" ]]; then echo -n \"~/.config/emacs/\"; else echo \"${initDir}\"; fi)"
  '';
  passthru = { inherit (emacs-pgtk) pkgs; };
  inherit (emacsUnwrapped) meta;
}

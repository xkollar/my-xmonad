{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    cabal-install
    haskell.compiler.ghc884
    haskellPackages.ghcid
    haskellPackages.xmobar
    pkg-config
    xorg.libX11
    xorg.libXft
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXScrnSaver
    xorg.libXext
    xorg.xmessage
    xorg.xmodmap
    imagemagickBig
  ];
}

{
  self,
  pkgs,
  lib,
  inputs,
  ...
}: rec {
  default = foucault;
  foucault = pkgs.callPackage ./foucault.nix {inherit pkgs inputs lib self;};
}

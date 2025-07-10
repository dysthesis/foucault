{
  pkgs,
  self,
  ripgrep,
  fd,
  kakoune,
  kakounePlugins,
  writeTextFile,
  lib,
  ...
}: let
  inherit (lib.babel.pkgs) mkWrapper;
  inherit (lib) makeBinPath;
  config = writeTextFile rec {
    name = "kakrc.kak";
    destination = "/share/kak/autoload/${name}";
    text = builtins.readFile "${self}/kakrc.kak";
  };

  customKakoune = kakoune.override {
    plugins = with kakounePlugins; [
      config
      parinfer-rust
      smarttab-kak
    ];
  };
  deps = [ripgrep fd];
in
  mkWrapper pkgs customKakoune ''
    wrapProgram $out/bin/kak \
      --prefix PATH ":" ${makeBinPath deps}
  ''

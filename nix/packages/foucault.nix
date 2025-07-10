{
  self,
  kakoune,
  kakounePlugins,
  writeTextFile,
  ...
}: let
  config = writeTextFile rec {
    name = "kakrc.kak";
    destination = "/share/kak/autoload/${name}";
    text = builtins.readFile "${self}/kakrc.kak";
  };
in
  kakoune.override {
    plugins = with kakounePlugins; [
      config
      parinfer-rust
      smarttab-kak
    ];
  }

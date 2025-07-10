{
  tree-sitter-grammars,
  kak-lsp,
  kak-tree-sitter,
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

  tree-sitter-conf = writeTextFile rec {
    name = "config.toml";
    destination = "/kak-tree-sitter/${name}";
    text = with tree-sitter-grammars;
      lib.foldlAttrs
      (
        acc: name: vals:
          acc
          + ''
            [language.${name}.grammar.source.local]
            path = "${vals.parser}"
            [language.${name}.grammar]
            compile = "cc"
            compile_args = ["-c", "-fpic", "../scanner.c", "../parser.c", "-I", ".."]
            compile_flags = ["-O3"]
            link = "cc"
            link_args = ["-shared", "-fpic", "scanner.o", "parser.o", "-o", "typescript.so"]
            link_flags = ["-O3"]
            [language.${name}.queries.source.local]
            path = "${vals.queries}"
            [language.${name}.queries]
            path = "${vals.queries}"
          ''
      )
      ""
      {
        nix = {
          parser = tree-sitter-nix + "/parser";
          queries = tree-sitter-nix + "/queries";
        };
        rust = {
          parser = tree-sitter-rust + "/parser";
          queries = tree-sitter-rust + "/queries";
        };
      };
  };

  customKakoune = kakoune.override {
    plugins = with kakounePlugins; [
      config
      parinfer-rust
      smarttab-kak
      kakoune-catppuccin
    ];
  };
  deps = [
    kak-lsp
    kak-tree-sitter
    ripgrep
    fd
  ];
in
  mkWrapper pkgs customKakoune ''
    wrapProgram $out/bin/kak \
      --prefix PATH ":" ${makeBinPath deps} \
      --set XDG_CONFIG_HOME "${tree-sitter-conf}"
  ''

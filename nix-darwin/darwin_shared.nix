{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      # General packages
      pkgs.htop
      pkgs.jq
      pkgs.bat
      pkgs.ripgrep
      pkgs.tree
      pkgs.wget
      pkgs.zip
      pkgs.unzip
      pkgs.neovim

      # Node.js development tools
      pkgs.nodePackages.npm # globally install npm
      pkgs.nodePackages.yarn
      pkgs.nodePackages.prettier
      pkgs.nodejs

      # Python packages
      pkgs.python3
      pkgs.pyenv
      pkgs.poetry
      pkgs.pipx

      # Rust
      pkgs.rustup
    ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };

    taps = [
      "nikitabobko/tap"
    ];
    brews = [
      "ack"
      "act"
      "openssl"
      "axel"
      "cargo-instruments"
      "cmake"
      "gnutls"
      "gnupg"
      "gpgme"
      "pam-u2f"
      "openjdk"
      "fd"
      "findutils"
      "fzf"
      "gawk"
      "gh"
      "git"
      "git-delta"
      "gnu-tar"
      "go"
      "httpie"
      "grep"
      "jd"
      "just"
      "hub"
      "libfido2"
      "luarocks"
      "llvm"
      "n"
      "parallel"
      "pgcli"
      "shellcheck"
      "trash"
      "watch"
      "yq"
      "zlib"
      "zplug"
      "zsh"
      "oven-sh/bun/bun"
      "libtermkey"
      "ollama"
    ];
    casks = [
      "obsidian"
      "warp"
      "1password-cli"
      "marta"
      "aerospace"
      "karabiner-elements"
      "cursor"
      "spotify"
      "gpg-suite"
      "orbstack"
      "alfred"
      "signal"
    ];

    masApps = {
      "Xcode" = 497799835;
      "Telegram"= 747648890;
    };
  };
}

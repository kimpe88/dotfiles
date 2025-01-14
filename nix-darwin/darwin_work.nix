{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [

    ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };

    taps = [
      "common-fate/granted"
    ];
    brews = [
      "awscli"
      "kubernetes-cli"
      "k6"
      "k9s"
      "helm"
      "grpcurl"
      "kops"
      "kubeseal"
      "minikube"
      "logcli"
      "tfenv"
      "protobuf"
      # Yubikey
      "gpg"
      "ykpers"
      "pinentry"
      "pinentry-mac"
      "ykman"
    ];
    casks = [
      "mitmproxy"
      "tableplus"
      "pritunl"
    ];

    masApps = {
      "Yubico Authenticator" = 1497506650;
    };
  };
}

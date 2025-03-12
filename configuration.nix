{
  config,
  lib,
  pkgs,
  ...
}:
let
  defaultUserName = "victor";
in
{
  imports = [
    ./gnome.nix
  ];

  config = {
    users.users."${defaultUserName}" = {
      isNormalUser = true;
      password = "123456";
      extraGroups = [
        "dialout"
        "feedbackd"
        "networkmanager"
        "video"
        "wheel"
      ];
    };
    services.openssh = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      fractal
      mission-center
    ];
    environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";

    zramSwap.enable = true;
    networking.firewall.enable = lib.mkForce false;

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    system.stateVersion = "24.11";
  };
}

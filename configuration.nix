{ config, lib, pkgs, ... }:

let
  inherit (lib) mkForce;
  system_type = config.mobile.system.type;
  defaultUserName = "victor";
in
{
  imports = [
    ./gnome.nix
  ];

  config = {
    users.users."${defaultUserName}" = {
      isNormalUser = true;
      password = "1234";
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

    sound.enable = true;
    hardware.pulseaudio.enable = true;
    zramSwap.enable = true;
    networking.firewall.enable = false;
    system.stateVersion = "23.05";
  };
}

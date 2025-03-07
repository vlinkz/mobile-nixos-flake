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

    environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";

    services.pulseaudio.enable = lib.mkForce false;
    # services.pipewire.enable = lib.mkForce false;
    zramSwap.enable = true;
    networking.firewall.enable = lib.mkForce false;
    system.stateVersion = "24.11";
  };
}

{ config, pkgs, inputs, ... }:
{
  environment.systemPackages = [
    inputs.nix-software-center.packages."aarch64-linux".nix-software-center
    inputs.nixos-conf-editor.packages."aarch64-linux".nixos-conf-editor
    inputs.snow.packages."aarch64-linux".snow
    pkgs.git # For rebuiling with github flakes
  ];
  programs.nix-data = {
    systemconfig = "/etc/nixos/configuration.nix";
    flake = "/etc/nixos/flake.nix";
    flakearg = "fajita";
  };
  snowflakeos.gnome.enable = true;
  snowflakeos.osInfo.enable = true;
}

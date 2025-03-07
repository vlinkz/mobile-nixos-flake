#
# This file represents safe opinionated defaults for a basic GNOME mobile system.
#
# NOTE: this file and any it imports **have** to be safe to import from
#       an end-user's config.
#
{ config, lib, pkgs, options, ... }:

{
  mobile.beautification = {
   silentBoot = lib.mkDefault true;
   splash = lib.mkDefault true;
  };

  programs.calls.enable = true;

  environment.systemPackages = with pkgs; [
    chatty              # IM and SMS
    epiphany            # Web browser
    gnome-console       # Terminal
    megapixels          # Camera
  ];

  hardware.sensor.iio.enable = true;
}

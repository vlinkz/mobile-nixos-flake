{
  config,
  lib,
  pkgs,
  options,
  ...
}:

{
  mobile.beautification = {
    silentBoot = lib.mkDefault true;
    splash = lib.mkDefault true;
  };

  programs.calls.enable = true;

  environment.systemPackages = with pkgs; [
    chatty # IM and SMS
    epiphany # Web browser
    gnome-console # Terminal
    megapixels # Camera
    gnome-software
  ];

  services.flatpak.enable = true;

  hardware.sensor.iio.enable = true;
}

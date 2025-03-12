{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    mobile-nixos = {
      url = "github:vlinkz/mobile-nixos/sdm845-6.14";
      flake = false;
    };
    gnome-mobile.url = "github:chuangzhu/nixpkgs-gnome-mobile";
  };

  outputs =
    inputs@{ nixpkgs, mobile-nixos, ... }:
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;
    in
    {

      nixosConfigurations.fajita = nixosSystem {
        system = "aarch64-linux";
        modules = [
          { _module.args = { inherit inputs; }; }
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.config.permittedInsecurePackages = [
              "olm-3.2.16"
            ];
          }
          (import "${inputs.mobile-nixos}/lib/configuration.nix" {
            device = "oneplus-fajita";
          })
          ./configuration.nix
          inputs.gnome-mobile.nixosModules.gnome-mobile
        ];
      };

      nixosConfigurations.uefi-x86_64 = nixosSystem {
        system = "x86_64-linux";
        modules = [
          { _module.args = { inherit inputs; }; }
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.config.permittedInsecurePackages = [
              "olm-3.2.16"
            ];
          }
          (import "${inputs.mobile-nixos}/lib/configuration.nix" {
            device = "uefi-x86_64";
          })
          ./configuration.nix
          inputs.gnome-mobile.nixosModules.gnome-mobile
        ];
      };

      nixosConfigurations.fajita_minimal = nixosSystem {
        system = "aarch64-linux";
        modules = [
          { _module.args = { inherit inputs; }; }
          (import "${inputs.mobile-nixos}/lib/configuration.nix" {
            device = "oneplus-fajita";
          })
        ];
      };

      fajita-fastboot-images =
        inputs.self.nixosConfigurations.fajita.config.mobile.outputs.android.android-fastboot-images;
      fajita-minimal-image =
        inputs.self.nixosConfigurations.fajita_minimal.config.mobile.outputs.android.android-fastboot-images;
      uefi-x86_64-image = inputs.self.nixosConfigurations.uefi-x86_64.config.mobile.outputs.default;
    };
}

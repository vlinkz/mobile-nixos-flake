{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    mobile-nixos = {
      url = "github:vlinkz/mobile-nixos/gnomelatest";
      flake = false;
    };
    snowflake.url = "github:snowflakelinux/snowflake-modules";
    nix-data.url = "github:snowflakelinux/nix-data";
    nix-software-center.url = "github:vlinkz/nix-software-center";
    nixos-conf-editor.url = "github:vlinkz/nixos-conf-editor";
    snow.url = "github:snowflakelinux/snow";
  };

  outputs = inputs @ { nixpkgs, mobile-nixos, ... }:
    let

      inherit (inputs.nixpkgs.lib) nixosSystem;
      inherit (inputs.flake-utils.lib) eachDefaultSystem;

    in
    {

      nixosConfigurations.fajita = nixosSystem {
        system = "aarch64-linux";
        modules = [
          { _module.args = { inherit inputs; }; }
          (import "${inputs.mobile-nixos}/lib/configuration.nix" {
            device = "oneplus-fajita";
          })
          ./configuration.nix
          ./snowflake.nix
          inputs.snowflake.nixosModules.snowflake
          inputs.nix-data.nixosModules."aarch64-linux".nix-data
        ];
      };

      nixosConfigurations.uefi-x86_64 = nixosSystem {
        system = "x86_64-linux";
        modules = [
          { _module.args = { inherit inputs; }; }
          (import "${inputs.mobile-nixos}/lib/configuration.nix" {
            device = "uefi-x86_64";
          })
          ./configuration.nix
        ];
      };

      fajita-fastboot-images = inputs.self.nixosConfigurations.fajita.config.mobile.outputs.android.android-fastboot-images;
      uefi-x86_64-image = inputs.self.nixosConfigurations.uefi-x86_64.config.mobile.outputs.default;
    };
}

{
  description = "flake-parts consumer flake example";

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs = {
        nixpkgs-lib.follows = "nixpkgs";
      };
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    hello-unfree-world = {
      url = "github:ink-splatters/flake-partitions-poc/dfc8f9d34978407ec5a020c1d772266c105c0789";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        systems.follows = "systems";
      };
    };
  };
  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} (let
      systems = import inputs.systems;
    in {
      imports = [
        inputs.hello-unfree-world.flakeModules.default
      ];
      inherit systems;

      perSystem = {self', ...}: {
        packages.default = self'.packages.hello-unfree;
      };
    });
}

{
  description = "flake-parts consumer flake example";

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs = {
        nixpkgs-lib.follows = "nixpkgs";
      };
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    hello-unfree-world = {
      url = "github:ink-splatters/flake-partitions-poc/e0498283eeb6751b9c79b6fc9baaa11694b81634";
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
    });
}

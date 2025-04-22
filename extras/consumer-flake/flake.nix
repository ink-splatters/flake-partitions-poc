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
      url = "github:ink-splatters/flake-partitions-poc/7183b3c9a0ab84004372397ca9274f08c1b2e00e";
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

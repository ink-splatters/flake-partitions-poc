{
  description = "flake-parts partitions PoC";

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs = {
        nixpkgs-lib.follows = "nixpkgs";
      };
    };
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };
  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} (let
      systems = import inputs.systems;
      flakeModules.default = import nix/flake-module.nix {inherit inputs;};
    in {
      debug = true;
      imports = [
        flake-parts.flakeModules.partitions
        flakeModules.default
      ];
      inherit systems;

      partitionedAttrs = {
        apps = "dev";
        checks = "dev";
        devShells = "dev";
        formatter = "dev";
      };
      partitions.dev = {
        extraInputsFlake = ./nix/dev;
        module = {
          imports = [./nix/dev/flake-module.nix];
        };
      };

      flake = {
        inherit flakeModules;
      };
    });
}

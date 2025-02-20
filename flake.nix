{
  description = "flake-parts partitions PoC";

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs = {
        nixpkgs-lib.follows = "nixpkgs";
      };
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };
  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} (let
      systems = import inputs.systems;
      flakeModules.default = import nix/flake-module.nix {inherit inputs;};
    in {
      # Uncomment this to explore option values,
      # see: https://flake.parts/debug.html
      # debug = true;
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

      # this won't be exported
      perSystem = {config,...}: {
        packages.default = config.packages.hello-unfree;
      };

      flake = {
        inherit flakeModules;
      };
    });
}

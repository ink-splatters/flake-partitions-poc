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
  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    ...
  }: let
    systems = import inputs.systems;
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        flake-parts.flakeModules.partitions
      ];
      inherit systems;

      perSystem = {
        pkgs,
        system,
        ...
      }: {
        # This sets `pkgs` to a nixpkgs with allowUnfree option set.
        _module.args.pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        packages.default = pkgs.hello-unfree;
      };

      partitionedAttrs = {
        apps = "dev";
        checks = "dev";
        devShells = "dev";
        formatter = "dev";
      };
      partitions.dev = {
        extraInputsFlake = ./dev;
        module = {
          imports = [./dev/flake-module.nix];
        };
      };
    };
}

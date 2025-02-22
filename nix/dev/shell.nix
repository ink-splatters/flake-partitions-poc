{
  perSystem = {
    config,
    pkgs,
    ...
  }: let
    inherit (config) pre-commit;
  in {
    devShells.default = pkgs.mkShell {
      nativeBuildInputs = pre-commit.settings.enabledPackages;
      shellHook = pre-commit.installationScript;
    };
  };
}

# nix flake partitioning

## TL;DR

The PoC implements [flake-parts partitions](https://flake.parts/options/flake-parts-partitions.html) functionality.

_Longer version_:

while the module system does a good job at preserving laziness, the fact that a development
related import can define packages means that in order to evaluate packages, you need to
evaluate at least to the point where you can conclude that the development related import
does not actually define a packages attribute. While the actual evaluation is cheap, it can
only happen after fetching the input, which is not as cheap.

The "production" flow of the PoC uses `nixpkgs#hello-unfree` under the hood.

## TODO: templates

- [GitHub](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-template-repository) template
- [flake (`nix flake init`)](https://nix.dev/manual/nix/2.25/command-ref/new-cli/nix3-flake-init), potentially upstreaming it

## Prerequisites

- `nix` with [flakes](https://nixos.wiki/wiki/Flakes) functionality enabled
- `direnv` [optionally, for development only]

## Hello `unfree` world

### ...free of development inputs

```sh
nix run github:ink-splatters/flake-partitions-poc
```

## Development

The flow uses another flake-parts _partition_ (and that's the whole point).

### Dev shell

```sh
nix develop --accept-flake-config
```

Alternatively, if you have `direnv` installed:

```sh
direnv allow .
```

### Formatter

Currently, the formatter is `alejandra`

```sh
nix fmt .
```

### pre-commit

Normally, pre-commit hooks are installed during dev shell initialization.
This also can be done manually, using:

```sh
nix run .#install-hooks
```

To manually run the checks:

```sh
nix flake check
```

## Extras

[Consumer flake](./extras/consumer-flake/README.md)

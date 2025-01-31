# nix flake partitioning

The PoC implements [flake-parts](https://flake.parts)
[partitions](https://flake.parts/options/flake-parts-partitions.html) functionality.

## TL;DR

While the module system does a good job at preserving laziness, the fact that a development
related import can define packages means that in order to evaluate packages, you need to
evaluate at least to the point where you can conclude that the development related import
does not actually define a packages attribute. While the actual evaluation is cheap, it can
only happen after fetching the input, which is not as cheap.

## Prerequisites

- `nix`
- `nix-command` and `flakes` experimental features enabled

## Hello world

...free of dev dependencies.

The goal of the test is to show that solely dev functionality (e.g. `devShells`) doesn't get evaluated
upon evaluating `packages.default`

```sh
nix flake run github:ink-splatters/flake-partitions-poc
```

## Development

### Dev shell

```sh
nix develop github:ink-splatters/flake-partitions-poc --accept-flake-config
```

### Run nix formatter

currently formatter is `alejandra`

```sh
nix fmt github:ink-splatters/flake-partitions-poc .
```

### Install pre-commit hooks

```sh
nix run github:ink-splatters/flake-partitions-poc#install-hooks
```

### Run pre-commit checks

```sh
nix flake check github:ink-splatters/flake-partitions-poc
```

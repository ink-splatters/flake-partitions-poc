# nix flake partitioning

The PoC implements [flake-parts](https://flake.parts)
[partitions](https://flake.parts/options/flake-parts-partitions.html) functionality.

## TL;DR

While the module system does a good job at preserving laziness, the fact that a development related import can define packages means that in order to evaluate packages, you need to evaluate at least to the point where you can conclude that the development related import does not actually define a packages attribute. While the actual evaluation is cheap, it can only happen after fetching the input, which is not as cheap.


## Test


## Prerequisites

- `nix` or [nix compatible](https://lix.systems) setup
- nix `flakes` enabled


## Hello world

...free of dev dependencies.

The goal of the test is to show that solely dev functionality (e.g. `devShells`) doesn't get evaluated
upon evaluating `packages.default`


```sh
nix flake run github:ink-splatters/flake-partitions-poc
```

## dev shell


```sh
nix develop github:ink-splatters/flake-partitions-poc --accept-flake-config
```


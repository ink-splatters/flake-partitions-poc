# flake parts consumer flake

This is an example of completely independent flake' importing what is exposed by import flake
(in this case: `unfree` flavor of `hello` package)

## Hello unfree world

```sh
nix flake run github:ink-splatters/flake-partitions-poc/extras/consumer-flake
```




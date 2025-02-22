# Consumer flake

This is just a simple example of consuming `flake-parts` flake.

```sh
nix run github:ink-splatters/flake-partitions-poc?dir=extras/consumer-flake#hello-unfree
```

NOTE: there is no `default` output on purpuse, in order to show that only explicit
export of the source flake gets imported.

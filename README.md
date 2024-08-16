# `github:clo4/mkshell`

Experiment: an easier way to create dev shells.

This is intended for my own **local-only** usage, not for publishing. When a
flake is published, it should ideally be more complete.

## Usage

First, add `mkshell` to your registry. Flake outputs automatically use the
registry for named attributes if there isn't an input corresponding to it.

```
nix registry add mkshell github:clo4/mkshell
```

When you're ready to create a dev environment, create a flake that takes
`mkshell` and `nixpkgs` as arguments to its outputs. The `nixpkgs` argument is
instantiated and passed to the function as the `pkgs` argument. The function
returns a valid argument for `pkgs.mkShell`.

```nix
{
  outputs = { mkshell, nixpkgs, ... }:
    mkshell.mkShell nixpkgs (pkgs: {
      packages = with pkgs; [
        # ...
      ];
    });
}
```

Now, with no inputs, no complicated outputs tree, and as minimal boilerplate as
is possible, you can now define a dev shell in your flake. Of course, it's not
quite as fast as the old `shell.nix` style:

```nix
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  packages = with pkgs; [
    # ...
  ];
}
```

... but you get all the advantages of using flakes at he cost of a couple extra
(mostly empty) lines.

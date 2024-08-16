{
  outputs = {
    nixpkgs,
    flake-utils,
    self,
  }: {
    lib.mkShell = shellFn:
      flake-utils.lib.eachDefaultSystem (system: let
        pkgs = nixpkgs.legacyPackages.${system};
        shell = shellFn pkgs;
      in {
        devShells.default = pkgs.mkShell shell;
      });
  };
}

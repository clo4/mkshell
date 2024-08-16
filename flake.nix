{
  outputs = {
    flake-utils,
    self,
  }: {
    mkShell = nixpkgs: fn:
      flake-utils.lib.eachDefaultSystem (system: let
        pkgs = nixpkgs.legacyPackages.${system};
        shell = fn pkgs;
      in {
        devShells.default = pkgs.mkShell shell;
      });
  };
}

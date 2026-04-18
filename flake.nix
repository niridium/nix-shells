{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  outputs =
    {
      self,
      nixpkgs,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system} = with pkgs; {
        rust = mkShell {
          packages = [
            cargo
            rustc
          ];
        };
        git = mkShell {
          packages = [
            pre-commit
            git-conventional-commits
            ggshield
          ];
        };
      };
    };
}

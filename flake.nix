{
  description = "Tools and scripts for a git repository";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells."${system}".default = pkgs.mkShell {
        packages = [
          pkgs.pre-commit
          pkgs.git-conventional-commits
          pkgs.ggshield
        ];
      };
    };
}

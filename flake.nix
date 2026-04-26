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
      overrides = (builtins.fromTOML (builtins.readFile ./rust-toolchain.toml));
    in
    {
      devShells.${system} = with pkgs; {
        rust = mkShell {
          stictDeps = true;
          nativeBuildInputs = [
            rustup
            rustPlatform.bindgenHook
          ];
          buildInputs = [ ];
          RUSTC_VERSION = overrides.toolchain.channel;
          shellHook = ''
            export PATH="''${CARGO_HOME:-~/.cargo}/bin":"$PATH";
            export PATH="''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-${stdenv.hostPlatform.rust.rustcTarget}/bin":"$PATH"
          '';
          # packages = [
          #   cargo
          #   rustc
          # ];
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

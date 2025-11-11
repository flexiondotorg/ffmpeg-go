{
  description = "ffmpeg-go";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:

    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            # Build tools
            curl
            ffmpeg
            gcc
            go
            just
            # LLVM/Clang for code generator (go-clang requires libclang)
            # llvmPackages.libclang provides: clang compiler + libclang library
            # llvmPackages.llvm provides: llvm-config command
            llvmPackages.libclang
            llvmPackages.llvm
            pkg-config
          ];

          # Environment for go-clang CGO compilation
          shellHook = ''
            export CGO_LDFLAGS="-L${pkgs.llvmPackages.libclang.lib}/lib"
            export CPATH="${pkgs.llvmPackages.libclang.dev}/include"
          '';
        };
      }
    );
}

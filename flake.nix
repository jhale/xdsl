{
  description = "xDSL devshell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
          mlir_xdsl = pkgs.llvmPackages_23; # mlir version compatible with xdsl
        in
          {
            devShells.default = with pkgs; mkShell {
              LD_LIBRARY_PATH = lib.makeLibraryPath [ stdenv.cc.cc.lib zlib ];
              buildInputs = [
                uv
                mlir_xdsl.llvm
                mlir_xdsl.mlir
                mlir_xdsl.tblgen
              ];
              LLVM_SYMBOLIZER_PATH = "${llvmPackages_23.llvm}/bin/llvm-symbolizer";
              XDSL_MLIR_OPT = "${llvmPackages_23.mlir}/bin/mlir-opt";
              XDSL_MLIR_TRANSLATE = "${llvmPackages_23.mlir}/bin/mlir-translate";
              XDSL_LLVM_DIFF = "${llvmPackages_23.llvm}/bin/llvm-diff";
              XDSL_LLI = "${llvmPackages_23.llvm}/bin/lli";
            };
          }
    );
}

{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pyPkgs = pkgs.python3Packages;
      category-encoders = pkgs.callPackage ./category-encoders.nix { 
        buildPythonPackage = pyPkgs.buildPythonPackage;
        numpy = pyPkgs.numpy;
        scikit-learn = pyPkgs.scikit-learn;
        scipy = pyPkgs.scipy;
        statsmodels = pyPkgs.statsmodels;
        pandas = pyPkgs.pandas;
        patsy = pyPkgs.patsy;
      };
    in
  {

    packages.x86_64-linux.default = pkgs.mkShell {
      packages = with pkgs; [
        jupyter-all 
        python3Packages.pandas
        python3Packages.scikit-learn
        python3Packages.numpy
        python3Packages.matplotlib
        python3Packages.statsmodels
        python3Packages.polars
        python3Packages.hvplot
        python3Packages.pyarrow
        python3Packages.graphviz
        # LSP's
        python3Packages.python-lsp-server
        # Not in nixpkgs
        category-encoders
        # Test category-encoders
        python3Packages.pytest
        # Non-python dependencies
        graphviz
      ];
      # shellHook = ''
      # PYTHONPATH=$(pwd)/.venv/lib/:$(pwd)/.venv/lib/python3.11/site-packages/
      # source $(pwd)/.venv/bin/activate
      # '';
      inputsFrom = with pkgs; [
        openblas.dev
      ];
    };
  };
}

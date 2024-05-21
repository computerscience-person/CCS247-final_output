{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system ; };
      category-encoders = let
        pname = "category-encoders";
        version = "2.6.3";
      in pkgs.python3Packages.buildPythonPackage {
        inherit pname version;
        src = pkgs.fetchurl {
          # inherit pname version;
          url = "https://files.pythonhosted.org/packages/3f/21/79a3fdf7998035ddd601ed4df6ac8b1e273ec61b30c05cf18df0042e308f/category_encoders-2.6.3.tar.gz";
          sha256 = "d9f14705ed4b536eaf9cfc81b76d67a50b2f16f8f3eda498c57d7da19655530c";
        };
        buildInputs = with pkgs.python3Packages; [
          numpy
          scikit-learn
          scipy
          statsmodels
          pandas
          patsy
        ];
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

{ buildPythonPackage
, fetchurl
, numpy
, scikit-learn
, scipy
, statsmodels
, pandas
, patsy
, lib
, stdenv
}:
let
  pname = "category-encoders";
  version = "2.6.3";
in
buildPythonPackage {
  inherit pname version;
  src = fetchurl {
    # inherit pname version;
    url = "https://files.pythonhosted.org/packages/3f/21/79a3fdf7998035ddd601ed4df6ac8b1e273ec61b30c05cf18df0042e308f/category_encoders-2.6.3.tar.gz";
    sha256 = "d9f14705ed4b536eaf9cfc81b76d67a50b2f16f8f3eda498c57d7da19655530c";
  };
  propagatedBuildInputs = [
    numpy
    scikit-learn
    scipy
    statsmodels
    pandas
    patsy
  ];
}

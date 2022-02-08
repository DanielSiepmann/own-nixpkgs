self: super: {
  rst2pdf = super.pkgs.python3.pkgs.buildPythonApplication rec {
    pname = "rst2pdf";
    version = "0.99";

    src = super.pkgs.python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "8fa23fa93bddd1f52d058ceaeab6582c145546d80f2f8a95974f3703bd6c8152";
    };

    # We do not install extras, and tests for extras might fail
    # Extras are sphinx, plantuml, …
    doCheck = false;

    propagatedBuildInputs = with super.pkgs.python3.pkgs; [
      docutils
      importlib-metadata
      jinja2
      packaging
      pygments
      pyyaml
      reportlab
      smartypants

      pillow
    ];

    meta = with super.lib; {
      description = "Convert reStructured Text to PDF via ReportLab.";
      homepage = "https://rst2pdf.org/";
      license = licenses.mit;
    };
  };
}

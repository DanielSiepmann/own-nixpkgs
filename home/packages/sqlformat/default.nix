{
  writeShellApplication,
  python3
}:

let
  python = python3.withPackages(python-packages: with python-packages; [
    sqlparse
  ]);

in writeShellApplication {
  name = "sqlformat";

  runtimeInputs = [
    python
  ];

  text = ''
    python3 -m sqlparse --keywords upper --identifiers lower --reindent_aligned --indent_width 4 <(cat -)
  '';
}

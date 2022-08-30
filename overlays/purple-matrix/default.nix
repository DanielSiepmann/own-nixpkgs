self: super: {
  purple-matrix = super.purple-matrix.overrideAttrs(old: {
    version = "2022-08-30";

    src = super.fetchFromGitHub {
      owner = "matrix-org";
      repo = "purple-matrix";
      rev = "9c5bffa94b9e0af13845cb7466c95a079f54a630";
      sha256 = "sha256-jihDunHNzQ+4ViN7t6AZ7gE5YbrCS7Iz3qsFvGfUZ7U=";
    };
  });
}

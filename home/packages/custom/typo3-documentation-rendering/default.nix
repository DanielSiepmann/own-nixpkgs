{
  writeShellApplication,
  podman
}:

writeShellApplication {
  name = "custom-typo3-render-documentation";

  runtimeInputs = [
    podman
  ];

  # See: https://t3docs.github.io/DRC-The-Docker-Rendering-Container/07-To-be-sorted/quickstart.html#build-html-with-plain-docker-commands
  text = ''
    podman \
      run --rm \
      -v "$(pwd)":/PROJECT:ro \
      -v "$(pwd)/Documentation-GENERATED-temp":/RESULT \
      docker.io/t3docs/render-documentation:latest \
      makehtml
  '';
}

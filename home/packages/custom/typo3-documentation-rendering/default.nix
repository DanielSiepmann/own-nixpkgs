{
  writeShellApplication,
  ownLib,
  podman
}:

let
  usePodman = ownLib.onHikari {};
  runner = if usePodman then "podman" else "docker";
  image = (if usePodman then "docker.io/" else "") + "t3docs/render-documentation:latest";
  runtimeInputs = if usePodman then [ podman ] else [ ];

in writeShellApplication {
  name = "custom-typo3-render-documentation";

  inherit runtimeInputs;

  # See: https://t3docs.github.io/DRC-The-Docker-Rendering-Container/07-To-be-sorted/quickstart.html#build-html-with-plain-docker-commands
  text = ''
    mkdir -p Documentation-GENERATED-temp
    ${runner} \
      run --rm \
      -v "$(pwd)":/PROJECT:ro \
      -v "$(pwd)/Documentation-GENERATED-temp":/RESULT \
      ${image} \
      makehtml
  '';
}

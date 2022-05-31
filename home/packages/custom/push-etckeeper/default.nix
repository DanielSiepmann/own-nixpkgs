{
  writeShellApplication,
  git
}:

writeShellApplication {
  name = "custom-push-etckeeper";

  runtimeInputs = [
    git
  ];

  text = ''
    mkdir /tmp/etckeeper
    cd /tmp/etckeeper
    sudo cp -r /etc/.git .
    sudo chown -R daniels:daniels .
    git push
    cd /tmp
    rm -rf /tmp/etckeeper
  '';
}

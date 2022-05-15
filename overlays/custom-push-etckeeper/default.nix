self: super:

{
  custom-push-etckeeper = super.pkgs.writeShellApplication {
    name = "custom-push-etckeeper";

    text = ''
      mkdir /tmp/etckeeper
      cd /tmp/etckeeper
      sudo cp -r /etc/.git .
      sudo chown -R daniels:daniels .
      git push
      cd /tmp
      rm -rf /tmp/etckeeper
    '';
  };
}

{
  writeShellApplication,
  borgbackup,
  git,
  rsync
}:

writeShellApplication {
  name = "custom-backup";

  runtimeInputs = [
    borgbackup
    rsync
    git
  ];

  text = ''
    borg create \
      -v \
      --progress \
      --stats \
      --exclude-from ~/.config/borg/exclude \
      /media/daniels/Backup/borg::"$(date +%F-%R)" \
      ~/

    rsync -az --delete ~/.config/nixpkgs /media/daniels/Backup/

    sudo rsync -az /etc/.git /media/daniels/Backup/etc/
    sudo chown daniels:daniels -R /media/daniels/Backup/etc/
    cd /media/daniels/Backup/etc/
    git reset --hard master
  '';
}

self: super:

{
  custom-backup = super.pkgs.writeShellApplication {
    name = "custom-backup";

    text = ''
      ${super.pkgs.borgbackup}/bin/borg create \
        -v \
        --progress \
        --stats \
        --exclude-from ~/.config/borg/exclude \
        /media/daniels/Backup/borg::"$(date +%F-%R)" \
        ~/

      ${super.pkgs.rsync}/bin/rsync -az ~/.config/nixpkgs /media/daniels/Backup/

      sudo ${super.pkgs.rsync}/bin/rsync -az /etc/.git /media/daniels/Backup/etc/
      sudo chown daniels:daniels -R /media/daniels/Backup/etc/
      cd /media/daniels/Backup/etc/
      ${super.pkgs.git}/bin/git reset --hard master
    '';
  };
}

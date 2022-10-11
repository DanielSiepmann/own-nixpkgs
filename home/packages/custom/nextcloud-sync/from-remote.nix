{
  writeShellApplication,
  rclone
}:

writeShellApplication {
  name = "custom-nextcloud-sync-from-remote";

  runtimeInputs = [
    rclone
  ];

  text = ''
    rclone sync -v --progress Nextcloud-Private:Documents ~/Documents/Nextcloud
    rclone sync -v --progress Nextcloud-Codappix:Documents ~/Documents/NextcloudCodappix/Documents/
  '';
}

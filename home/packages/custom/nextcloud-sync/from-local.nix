{
  writeShellApplication,
  rclone
}:

writeShellApplication {
  name = "custom-nextcloud-sync-from-local";

  runtimeInputs = [
    rclone
  ];

  text = ''
    rclone sync -v --progress ~/Documents/Nextcloud Nextcloud-Private:Documents
    rclone sync -v --progress ~/Documents/NextcloudCodappix/Documents/ Nextcloud-Codappix:Documents
  '';
}

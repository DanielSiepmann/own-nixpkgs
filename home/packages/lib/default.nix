{
  onHikari = _: builtins.readFile(/etc/hostname) == "hikari\n";
}

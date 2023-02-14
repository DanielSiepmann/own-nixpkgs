{
  writeShellApplication,
  php82,
  php82Packages,
  git
}:

writeShellApplication {
  name = "custom-build-phpactor";

  runtimeInputs = [
    php82
    php82Packages.composer
    git
  ];

  # TODO: Use nix build environment?!
  text = ''
    rm -rf /tmp/phpactor
    mkdir /tmp/phpactor
    cd /tmp/phpactor
    git clone --depth 1 https://github.com/phpactor/phpactor.git .
    composer install -o --no-dev
    version=$(git show -s --format=%H)
    rm -rf .git/
    cd /tmp
    tar -czf "phpactor-$version.tar.gz" phpactor
    rsync -vaz "phpactor-$version.tar.gz" daniel-siepmann.de:webs/daniel-siepmann.de/htdocs/public/fileadmin/
    cd /tmp
    rm -rf /tmp/phpactor "phpactor-$version.tar.gz"
  '';
}

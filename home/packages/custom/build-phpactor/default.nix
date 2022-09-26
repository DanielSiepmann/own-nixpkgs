{
  writeShellApplication,
  php80,
  php80Packages,
  git
}:

writeShellApplication {
  name = "custom-build-phpactor";

  runtimeInputs = [
    php80
    php80Packages.composer
    git
  ];

  # TODO: Use nix build environment?!
  text = ''
    rm -rf /tmp/phpactor-build
    mkdir /tmp/phpactor-build
    cd /tmp/phpactor-build
    git clone --depth 1 https://github.com/phpactor/phpactor.git .
    composer install -o --no-dev
    version=$(git show -s --format=%H)
    rm -rf .git/
    cd /tmp
    tar -czf "phpactor-$version.tar.gz" /tmp/phpactor-build/*
    rsync -vaz "phpactor-$version.tar.gz" daniel-siepmann.de:webs/daniel-siepmann.de/htdocs/public/fileadmin/
    rm -rf /tmp/phpactor-build "phpactor-$version.tar.gz"
  '';
}

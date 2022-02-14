self: super: {

  # Still has many references to Ubuntu system tools.
  # Will migrate step by step and update references.

  # For now it is cool to have a first custom package which can be installed.

  # It already uses nix dunst and dmenu.
  # Also things like version switch should not be necessary once I managed nix shells.

  dmenu-custom-scripts-calc = super.pkgs.writeShellApplication {
    name = "dmenu-custom-scripts-calc";

    runtimeInputs = [
      super.pkgs.dmenu
      super.pkgs.bc
    ];

    text = ''
      input=$(dmenu -i)
      result=$(echo "$input" | scale=4 bc -l)
      echo "$result" | dmenu -i -p "Result:"
    '';
  };

  dmenu-custom-scripts-notifications = super.pkgs.writeShellApplication {
    name = "dmenu-custom-scripts-notifications";

    runtimeInputs = [
      super.pkgs.dmenu
      super.pkgs.dunst
    ];

    text = ''
      chosen=$(echo -e "pause\nresume" | dmenu -i)
      case "$chosen" in
      "pause")
        dunstctl set-paused true
        ;;
      "resume")
        dunstctl set-paused false
        ;;
      *)
        exit 0
        ;;
      esac
    '';
  };

  dmenu-custom-scripts-system = super.pkgs.writeShellApplication {
    name = "dmenu-custom-scripts-system";

    runtimeInputs = [
      super.pkgs.dmenu
      super.pkgs.dunst
    ];

    text = builtins.readFile ./system.sh;
  };

  dmenu-custom-scripts-docs-php = super.pkgs.writeShellApplication {
    name = "dmenu-custom-scripts-docs-php";

    runtimeInputs = [
      super.pkgs.dmenu
    ];

    text = ''
      file=$(find ~/Projects/docs/php/ -maxdepth 1 -name '*.html' -printf "%f\n" | dmenu -i -l 20 -p "Search Term")
      firefox --new-tab "http://php.docs.localhost/$file"
    '';
  };

  dmenu-custom-scripts-php-version = super.pkgs.writeShellApplication {
    name = "dmenu-custom-scripts-php-version";

    runtimeInputs = [
      super.pkgs.dmenu
    ];

    text = ''
      chosen=$(update-alternatives --list php | dmenu -i -l 20 -p "$(php --version | head -1 | cut -d' ' -f2 | cut -d'.' -f1,2)")
      sudo update-alternatives --set php "$chosen" > /dev/null
      pkill -SIGRTMIN+10 i3blocks
      notify-send "switching php version" "$(php --version)"
    '';
  };

  dmenu-custom-scripts-composer-version = super.pkgs.writeShellApplication {
    name = "dmenu-custom-scripts-composer-version";

    runtimeInputs = [
      super.pkgs.dmenu
    ];

    text = ''
      chosen=$(echo -e "1\n2\n"| dmenu -i -l 20 -p "$(composer --version)")
      composer selfupdate --"$chosen"
      pkill -SIGRTMIN+10 i3blocks
      notify-send "switching composer version" "$(composer --version)"
    '';
  };

  dmenu-custom-scripts-xdebug = super.pkgs.writeShellApplication {
    name = "dmenu-custom-scripts-xdebug";

    runtimeInputs = [
      super.pkgs.dmenu
    ];

    text = builtins.readFile ./xdebug.sh;
  };

  dmenu-custom-scripts = super.pkgs.writeShellApplication {
    name = "dmenu_selection";

    # TODO: Find way to remove the nix prefixes from "files"
    text = ''
      scripts=()
      scripts+=("${super.pkgs.dmenu-custom-scripts-calc.name}")
      scripts+=("${super.pkgs.dmenu-custom-scripts-notifications.name}")
      scripts+=("${super.pkgs.dmenu-custom-scripts-system.name}")
      scripts+=("${super.pkgs.dmenu-custom-scripts-docs-php.name}")
      scripts+=("${super.pkgs.dmenu-custom-scripts-php-version.name}")
      scripts+=("${super.pkgs.dmenu-custom-scripts-composer-version.name}")
      scripts+=("${super.pkgs.dmenu-custom-scripts-xdebug.name}")

      OIFS="$IFS" IFS=$'\n'
      scriptsString="''${scripts[*]}"
      IFS="$OIFS"

      action=$(echo -e "$scriptsString" | dmenu -i -l 20)

      case "$action" in
      "${super.pkgs.dmenu-custom-scripts-calc.name}")
        bash "${super.pkgs.dmenu-custom-scripts-calc}/bin/${super.pkgs.dmenu-custom-scripts-calc.name}" || exit 0
        ;;
      "${super.pkgs.dmenu-custom-scripts-notifications.name}")
        bash "${super.pkgs.dmenu-custom-scripts-notifications}/bin/${super.pkgs.dmenu-custom-scripts-notifications.name}" || exit 0
        ;;
      "${super.pkgs.dmenu-custom-scripts-system.name}")
        bash "${super.pkgs.dmenu-custom-scripts-system}/bin/${super.pkgs.dmenu-custom-scripts-system.name}" || exit 0
        ;;
      "${super.pkgs.dmenu-custom-scripts-docs-php.name}")
        bash "${super.pkgs.dmenu-custom-scripts-docs-php}/bin/${super.pkgs.dmenu-custom-scripts-docs-php.name}" || exit 0
        ;;
      "${super.pkgs.dmenu-custom-scripts-php-version.name}")
        bash "${super.pkgs.dmenu-custom-scripts-php-version}/bin/${super.pkgs.dmenu-custom-scripts-php-version.name}" || exit 0
        ;;
      "${super.pkgs.dmenu-custom-scripts-composer-version.name}")
        bash "${super.pkgs.dmenu-custom-scripts-composer-version}/bin/${super.pkgs.dmenu-custom-scripts-composer-version.name}" || exit 0
        ;;
      "${super.pkgs.dmenu-custom-scripts-xdebug.name}")
        bash "${super.pkgs.dmenu-custom-scripts-xdebug}/bin/${super.pkgs.dmenu-custom-scripts-xdebug.name}" || exit 0
        ;;
      *)
        exit 0
        ;;
      esac
    '';
  };
}

{
  writeShellApplication,
  dmenu,
  dunst,
  libnotify,
  bc,
  i3,
  xdg-utils
}:

let

  # Things like version switch should not be necessary once I managed nix shells.

  dmenu-custom-scripts-calc = writeShellApplication {
    name = "dmenu-custom-scripts-calc";

    runtimeInputs = [
      dmenu
      bc
    ];

    text = ''
      input=$(dmenu -i)
      result=$(echo "$input" | scale=4 bc -l)
      echo "$result" | dmenu -i -p "Result:"
    '';
  };

  dmenu-custom-scripts-notifications = writeShellApplication {
    name = "dmenu-custom-scripts-notifications";

    runtimeInputs = [
      dmenu
      dunst
    ];

    text = ''
      chosen=$(echo -e "pause\nresume" | dmenu -i -l 2)
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

  dmenu-custom-scripts-system = writeShellApplication {
    name = "dmenu-custom-scripts-system";

    runtimeInputs = [
      i3
      dmenu
      dunst
    ];

    text = builtins.readFile ./system.sh;
  };

  dmenu-custom-scripts-docs-php = writeShellApplication {
    name = "dmenu-custom-scripts-docs-php";

    runtimeInputs = [
      dmenu
      xdg-utils
    ];

    text = ''
      file=$(find ~/Projects/docs/php/ -maxdepth 1 -name '*.html' -printf "%f\n" | dmenu -i -l 20 -p "Search Term")
      xdg-open "http://php.docs.localhost/$file"
    '';
  };

  dmenu-custom-scripts-php-version = writeShellApplication {
    name = "dmenu-custom-scripts-php-version";

    runtimeInputs = [
      dmenu
      libnotify
    ];

    text = ''
      chosen=$(update-alternatives --list php | dmenu -i -l 20 -p "$(php --version | head -1 | cut -d' ' -f2 | cut -d'.' -f1,2)")
      sudo update-alternatives --set php "$chosen" > /dev/null
      pkill -SIGRTMIN+10 i3blocks
      notify-send "switching php version" "$(php --version)"
    '';
  };

  dmenu-custom-scripts-xdebug = writeShellApplication {
    name = "dmenu-custom-scripts-xdebug";

    runtimeInputs = [
      dmenu
      libnotify
    ];

    text = builtins.readFile ./xdebug.sh;
  };

  dmenu-custom-scripts-open-issue = writeShellApplication {
    name = "dmenu-custom-scripts-open-issue";

    runtimeInputs = [
      dmenu
    ];

    text = builtins.readFile ./customer-issue.sh;
  };

in
writeShellApplication {
  name = "custom-dmenu-selection";

  # TODO: Find way to remove the nix prefixes from "files"
  text = ''
    scripts=()
    scripts+=("${dmenu-custom-scripts-calc.name}")
    scripts+=("${dmenu-custom-scripts-notifications.name}")
    scripts+=("${dmenu-custom-scripts-open-issue.name}")
    scripts+=("${dmenu-custom-scripts-system.name}")
    scripts+=("${dmenu-custom-scripts-php-version.name}")
    scripts+=("${dmenu-custom-scripts-docs-php.name}")
    scripts+=("${dmenu-custom-scripts-xdebug.name}")

    OIFS="$IFS" IFS=$'\n'
    scriptsString="''${scripts[*]}"
    IFS="$OIFS"

    action=$(echo -e "$scriptsString" | dmenu -i -l 20)

    case "$action" in
    "${dmenu-custom-scripts-calc.name}")
      bash "${dmenu-custom-scripts-calc}/bin/${dmenu-custom-scripts-calc.name}" || exit 0
      ;;
    "${dmenu-custom-scripts-notifications.name}")
      bash "${dmenu-custom-scripts-notifications}/bin/${dmenu-custom-scripts-notifications.name}" || exit 0
      ;;
    "${dmenu-custom-scripts-open-issue.name}")
      bash "${dmenu-custom-scripts-open-issue}/bin/${dmenu-custom-scripts-open-issue.name}" || exit 0
      ;;
    "${dmenu-custom-scripts-system.name}")
      bash "${dmenu-custom-scripts-system}/bin/${dmenu-custom-scripts-system.name}" || exit 0
      ;;
    "${dmenu-custom-scripts-docs-php.name}")
      bash "${dmenu-custom-scripts-docs-php}/bin/${dmenu-custom-scripts-docs-php.name}" || exit 0
      ;;
    "${dmenu-custom-scripts-php-version.name}")
      bash "${dmenu-custom-scripts-php-version}/bin/${dmenu-custom-scripts-php-version.name}" || exit 0
      ;;
    "${dmenu-custom-scripts-xdebug.name}")
      bash "${dmenu-custom-scripts-xdebug}/bin/${dmenu-custom-scripts-xdebug.name}" || exit 0
      ;;
    *)
      exit 0
      ;;
    esac
  '';
}

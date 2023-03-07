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
    scripts+=("${dmenu-custom-scripts-notifications.name}")
    scripts+=("${dmenu-custom-scripts-open-issue.name}")
    scripts+=("${dmenu-custom-scripts-system.name}")

    OIFS="$IFS" IFS=$'\n'
    scriptsString="''${scripts[*]}"
    IFS="$OIFS"

    action=$(echo -e "$scriptsString" | dmenu -i -l 20)

    case "$action" in
    "${dmenu-custom-scripts-notifications.name}")
      bash "${dmenu-custom-scripts-notifications}/bin/${dmenu-custom-scripts-notifications.name}" || exit 0
      ;;
    "${dmenu-custom-scripts-open-issue.name}")
      bash "${dmenu-custom-scripts-open-issue}/bin/${dmenu-custom-scripts-open-issue.name}" || exit 0
      ;;
    "${dmenu-custom-scripts-system.name}")
      bash "${dmenu-custom-scripts-system}/bin/${dmenu-custom-scripts-system.name}" || exit 0
      ;;
    *)
      exit 0
      ;;
    esac
  '';
}

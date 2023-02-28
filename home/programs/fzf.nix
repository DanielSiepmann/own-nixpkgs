{ }:

{
  enable = true;

  enableBashIntegration = false;
  enableFishIntegration = false;

  enableZshIntegration = true;

  # See: https://github.com/junegunn/fzf/wiki/Color-schemes
  colors = {
    "fg" = "#D3D7CF";
    "fg+" = "#D3D7CF";
    "bg" = "#2E3436";
    "bg+" = "#000000";

    "hl" = "#72B3CC";
    "hl+" = "#72B3CC";
    "pointer" = "#72B3CC";
    "info" = "#72B3CC";
    "marker" = "#72B3CC";
    "spinner" = "#72B3CC";
    "prompt" = "#72B3CC";
    "header" = "#72B3CC";
  };

  tmux = {
    enableShellIntegration = true;
    shellIntegrationOptions = [
      "-p" # Use pop up window
      "-y 1" # Place on top
      "-w 95%"
      "-h 75%"
    ];
  };
}

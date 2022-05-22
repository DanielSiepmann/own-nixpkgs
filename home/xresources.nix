{ config }:

{
  properties = {
    "Xcursor.theme" = "${config.gtk.cursorTheme.name}";
    "Xcursor.size" = 16;
  };
}

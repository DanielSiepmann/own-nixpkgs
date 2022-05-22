{ lib }:

{
  enable = true;
  settings = {
    "org/gtk/settings/file-chooser" = {
      date-format = "with-time";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 249;
      sort-column = "size";
      sort-directories-first = true;
      sort-order = "ascending";
      type-format = "category";
      window-position = lib.hm.gvariant.mkTuple [652 415];
      window-size = lib.hm.gvariant.mkTuple [1256 634];
    };

    "org/gnome/sound-juicer" = {
      audio-profile = "audio/mpeg";
      base-uri = "file:///home/daniels/Music";
      device = "/dev/sr0";
      eject = true;
      file-pattern = "%dn - %tt";
      path-pattern = "%aa/%at";
      strip-special = true;
      volume = 1.0;
    };
  };
}

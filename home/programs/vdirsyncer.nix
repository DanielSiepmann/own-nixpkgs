{ pkgs, config }:

{
  enable = true;

  frequency = "Mon..Thu *-*-* 15,12,8:00";

  # Run `vdirsyncer discover <name>` after adding a new pair

  configuration = ''
    [general]
    status_path = "${config.xdg.dataHome}/vdirsyncer/status/"

    [pair private_calendar]
    a = "private_calendar_local"
    b = "private_calendar_remote"
    collections = ["from a", "from b"]
    [storage private_calendar_local]
    type = "filesystem"
    path = "${config.xdg.dataHome}/vdir/calendars/private/"
    fileext = ".ics"
    [storage private_calendar_remote]
    type = "caldav"
    url = "https://nextcloud.daniel-siepmann.de/remote.php/dav"
    username = "dsiepmann"
    password.fetch = ["command", "${pkgs.libsecret}/bin/secret-tool", "lookup", "account", "app-dsiepmann@nextcloud.daniel-siepmann.de"]
    start_date = "datetime.now() - timedelta(days=60)"
    end_date = "datetime.now() + timedelta(days=365)"

    [pair holidays]
    a = "holidays_calendar_private"
    b = "holidays_calendar_public"
    collections = null
    [storage holidays_calendar_private]
    type = "caldav"
    url = "https://nextcloud.daniel-siepmann.de/remote.php/dav/calendars/dsiepmann/feiertage-synced/"
    username = "dsiepmann"
    password.fetch = ["command", "${pkgs.libsecret}/bin/secret-tool", "lookup", "account", "app-dsiepmann@nextcloud.daniel-siepmann.de"]
    [storage holidays_calendar_public]
    type = "http"
    url = "https://feiertage.ics.tools/nordrhein-westfalen.ics"

    [pair company_calendar]
    a = "company_calendar_local"
    b = "company_calendar_remote"
    collections = ["from a", "from b"]
    [storage company_calendar_local]
    type = "filesystem"
    path = "${config.xdg.dataHome}/vdir/calendars/company/"
    fileext = ".ics"
    [storage company_calendar_remote]
    type = "caldav"
    url = "https://nextcloud.codappix.com/remote.php/dav"
    username = "daniel.siepmann"
    password.fetch = ["command", "${pkgs.libsecret}/bin/secret-tool", "lookup", "account", "app-dsiepmann@nextcloud.codappix.com"]
    start_date = "datetime.now() - timedelta(days=60)"
    end_date = "datetime.now() + timedelta(days=365)"

    [pair sac_team]
    a = "sac_team_calendar_private"
    b = "sac_team_calendar_public"
    collections = null
    [storage sac_team_calendar_private]
    type = "caldav"
    url = "https://nextcloud.codappix.com/remote.php/dav/calendars/daniel.siepmann/sac-scrum-team-synced/"
    username = "daniel.siepmann"
    password.fetch = ["command", "${pkgs.libsecret}/bin/secret-tool", "lookup", "account", "app-dsiepmann@nextcloud.codappix.com"]
    [storage sac_team_calendar_public]
    type = "http"
    url = "https://calendar.google.com/calendar/ical/0ks410dho8f5ohcik361i4c2bs%40group.calendar.google.com/public/basic.ics"
  '';
}

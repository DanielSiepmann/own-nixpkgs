{ config }:

{
  enable = true;

  frequency = "*-*-* *:14,29,44,59:00";
  time_delta = "16m";

  configuration = ''
    [calendars]

    [[private]]
    path = ${config.xdg.dataHome}/vdir/calendars/private/personal
    color = dark blue
    [[arbeit]]
    path = ${config.xdg.dataHome}/vdir/calendars/private/imported-arbeitics
    color = dark red
    [[birthdays]]
    path = ${config.xdg.dataHome}/vdir/calendars/private/contact_birthdays
    color = dark green
    [[typo3]]
    path = ${config.xdg.dataHome}/vdir/calendars/private/typo3
    color = #FFE377

    [[work]]
    path = ${config.xdg.dataHome}/vdir/calendars/company/personal
    color = dark red
    [[sac_scrum_team]]
    path = ${config.xdg.dataHome}/vdir/calendars/company/sac-scrum-team-synced
    color = dark red

    [locale]
    local_timezone= Europe/Berlin
    default_timezone= Europe/Berlin
  '';
}

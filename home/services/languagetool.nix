{ pkgs, settings }:

{
  Unit = {
    Description = "Languagetool Server";
    StartLimitBurst = 3;
    StartLimitInterval = 400;
  };

  Service = {
    Restart = "on-failure";
    RestartSec = "2s";
    Environment = "JAVA_TOOL_OPTIONS=-Xmx256m";
    ExecStart = "${pkgs.languagetool}/bin/languagetool-http-server --port ${settings.port} --allow-origin ${settings.allow-origin}";
  };

  Install = {
    WantedBy = ["default.target"];
  };
}

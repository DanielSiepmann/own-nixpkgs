{ pkgs }:

{
  Unit = {
    Description = "Languagetool Server";
    StartLimitBurst = 3;
    StartLimitInterval = 400;
  };

  Service = {
    Restart = "on-failure";
    RestartSec = "2s";
    # TODO: Make memory optional and configurable
    Environment = "JAVA_TOOL_OPTIONS=-Xmx256m";
    # TODO: Make port and allow optional and configurable
    ExecStart = "${pkgs.languagetool}/bin/languagetool-http-server --port 8081 --allow-origin \"*\"";
  };

  Install = {
    WantedBy = ["default.target"];
  };
}

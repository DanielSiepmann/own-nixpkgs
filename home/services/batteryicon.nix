{ pkgs }:

{
  Unit = {
    Description = "Battery Icon";
    PartOf = "graphical-session.target";
  };

  Service = {
    ExecStart = "${pkgs.cbatticon}/bin/cbatticon -u 30";
  };

  Install = {
    WantedBy = [
      "hm-graphical-session.target"
    ];
  };
}

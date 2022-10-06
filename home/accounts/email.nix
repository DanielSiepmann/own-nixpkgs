{ config, pkgs }:

{
  maildirBasePath = "${config.xdg.dataHome}/maildir";

  accounts = {
    Private = rec {
      primary = true;
      address = "daniel@daniel-siepmann.de";
      aliases = [
        "coding@daniel-siepmann.de"
      ];
      realName = "Daniel Siepmann";

      gpg = {
        key = "15560EF4";
        signByDefault = true;
        encryptByDefault = true;
      };

      folders = {
        inbox = "INBOX";
      };

      maildir = {
        path = "private";
      };
      flavor = "plain";
      userName = address;
      # TODO: Somehow define once in a central place and only add the account name
      passwordCommand = "${pkgs.libsecret}/bin/secret-tool lookup account daniel@daniel-siepmann.de";
      imap = {
        host = "imap.mailbox.org";
        port = 993;
        tls = {
          enable = true;
        };
      };
      smtp = {
        host = "smtp.mailbox.org";
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };

      # TODO: Create a sytemd service + timer
      offlineimap.enable = true;
      neomutt = {
        enable = true;
        extraMailboxes = [
          "Archives.2018"
          "Archives.2019"
          "Archives.2020"
          "Archives.2021"
          "Archives.2022"
          "Archives.Rechnungen"
          "GerritOrGitHub.NIX"
          "GerritOrGitHub.phpactor"
          "GerritOrGitHub.TYPO3-Forge"
          "GerritOrGitHub.TYPO3-Gerrit"
          "GerritOrGitHub.TYPO3-Tea"
          "Junk"
        ];
      };
    };
  };
}

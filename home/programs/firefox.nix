{ pkgs }:

{
  enable = true;

  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.firefox.profiles
  # https://github.com/pyllyukko/user.js

  profiles = {
    default = {
      # Extensions:
      # * https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/
      # * https://addons.mozilla.org/en-US/firefox/addon/languagetool/
      # * https://addons.mozilla.org/en-US/firefox/addon/keepassxc-browser/
      name = "default";
      id = 0;
      isDefault = true;
      search = {
        default = "DuckDuckGo";
        order = [
          "DuckDuckGo"
          "PHP.net"
          "MDN (developer.mozilla.org)"
          "Nix Packages"
        ];
        engines = {
          "PHP.net" = {
            urls = [{
              template = "https://www.php.net/manual-lookup.php";
              params = [
                { name = "scope"; value = "quickref"; }
                { name = "pattern"; value = "{searchTerms}"; }
              ];
            }];

            icon = ./../../assets/php.png;
            definedAliases = [ "@php" ];
          };
          "MDN (developer.mozilla.org)" = {
            urls = [{
              template = "https://developer.mozilla.org/en-US/search";
              params = [
                { name = "q"; value = "{searchTerms}"; }
              ];
            }];

            icon = ./../../assets/mdn.png;
            definedAliases = [ "@mdn" ];
          };
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "channel"; value = "unstable"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "Bing".metaData.hidden = true;
          "Google".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Amazon.de".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
        force = true;
      };
      settings = {
        "browser.download.dir" = "/home/daniels/Downloads";

        "browser.compactmode.show" = true;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "accessibility.typeaheadfind.flashBar" = 0;
        "browser.tabs.inTitlebar" = 0;
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.uiCustomization.state" = "{\"placements\":{\"widget-overflow-fixed-list\":[\"jid1-mnnxcxisbpnsxq_jetpack-browser-action\",\"keepassxc-browser_keepassxc_org-browser-action\",\"floccus_handmadeideas_org-browser-action\",\"languagetool-webextension_languagetool_org-browser-action\",\"https-everywhere-eff_eff_org-browser-action\",\"chrome-gnome-shell_gnome_org-browser-action\",\"stop-reload-button\",\"sync-button\",\"library-button\",\"sidebar-button\",\"bookmarks-menu-button\",\"fullscreen-button\",\"fxa-toolbar-menu-button\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"urlbar-container\",\"_bf855ead-d7c3-4c7b-9f88-9a7e75c0efdf_-browser-action\",\"_2b10c1c8-a11f-4bad-fe9c-1c11e82cac42_-browser-action\",\"87677a2c52b84ad3a151a4a72f5bd3c4_jetpack-browser-action\",\"downloads-button\",\"_testpilot-containers-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"cors-everywhere_spenibus-browser-action\",\"_8d9dd0f0-6dc5-4595-8c81-fab876d0fef0_-browser-action\",\"firenvim_lacamb_re-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"personal-bookmarks\",\"managed-bookmarks\"]},\"seen\":[\"developer-button\",\"webide-button\",\"firefox_ghostery_com-browser-action\",\"chrome-gnome-shell_gnome_org-browser-action\",\"_bf855ead-d7c3-4c7b-9f88-9a7e75c0efdf_-browser-action\",\"_2b10c1c8-a11f-4bad-fe9c-1c11e82cac42_-browser-action\",\"feed-button\",\"jid1-mnnxcxisbpnsxq_jetpack-browser-action\",\"87677a2c52b84ad3a151a4a72f5bd3c4_jetpack-browser-action\",\"_axe-firefox-devtools-browser-action\",\"_testpilot-containers-browser-action\",\"languagetool-webextension_languagetool_org-browser-action\",\"https-everywhere-eff_eff_org-browser-action\",\"_74145f27-f039-47ce-a470-a662b129930a_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"save-to-pocket-button\",\"cors-everywhere_spenibus-browser-action\",\"_8d9dd0f0-6dc5-4595-8c81-fab876d0fef0_-browser-action\",\"firenvim_lacamb_re-browser-action\",\"floccus_handmadeideas_org-browser-action\",\"keepassxc-browser_keepassxc_org-browser-action\"],\"dirtyAreaCache\":[\"PersonalToolbar\",\"nav-bar\",\"TabsToolbar\",\"toolbar-menubar\",\"widget-overflow-fixed-list\"],\"currentVersion\":18,\"newElementCount\":23}";
        "extensions.ui.dictionary.hidden" = false;
        "extensions.ui.experiment.hidden" = true;
        "extensions.ui.extension.hidden" = false;
        "extensions.ui.locale.hidden" = false;
        "extensions.ui.sitepermission.hidden" = true;
        "extensions.webcompat.enable_picture_in_picture_overrides" = true;
        "findbar.highlightAll" = true;
        "lightweightThemes.persisted.footerURL" = false;
        "lightweightThemes.persisted.headerURL" = false;
        "lightweightThemes.usedThemes" = "[]";

        "browser.urlbar.matchBuckets" = "general:5,suggestion:Infinity";
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.placeholderName.private" = "DuckDuckGo";
        "browser.urlbar.resultBuckets" = "{\"children\":[{\"maxResultCount\":1,\"children\":[{\"group\":\"heuristicTest\"},{\"group\":\"heuristicExtension\"},{\"group\":\"heuristicSearchTip\"},{\"group\":\"heuristicOmnibox\"},{\"group\":\"heuristicUnifiedComplete\"},{\"group\":\"heuristicAutofill\"},{\"group\":\"heuristicTokenAliasEngine\"},{\"group\":\"heuristicFallback\"}]},{\"group\":\"extension\",\"maxResultCount\":5},{\"flexChildren\":true,\"children\":[{\"group\":\"general\",\"flex\":2},{\"flexChildren\":true,\"children\":[{\"flex\":2,\"group\":\"formHistory\"},{\"flex\":4,\"group\":\"remoteSuggestion\"},{\"flex\":0,\"group\":\"tailSuggestion\"}],\"flex\":1}]}]}";
        "browser.urlbar.resultGroups" = "{\"children\":[{\"maxResultCount\":1,\"children\":[{\"group\":\"heuristicTest\"},{\"group\":\"heuristicExtension\"},{\"group\":\"heuristicSearchTip\"},{\"group\":\"heuristicOmnibox\"},{\"group\":\"heuristicEngineAlias\"},{\"group\":\"heuristicBookmarkKeyword\"},{\"group\":\"heuristicAutofill\"},{\"group\":\"heuristicPreloaded\"},{\"group\":\"heuristicTokenAliasEngine\"},{\"group\":\"heuristicFallback\"}]},{\"group\":\"extension\",\"availableSpan\":5},{\"flexChildren\":true,\"children\":[{\"group\":\"generalParent\",\"children\":[{\"availableSpan\":3,\"group\":\"inputHistory\"},{\"flexChildren\":true,\"children\":[{\"flex\":1,\"group\":\"remoteTab\"},{\"flex\":2,\"group\":\"general\"},{\"flex\":2,\"group\":\"aboutPages\"},{\"flex\":1,\"group\":\"preloaded\"}]},{\"group\":\"inputHistory\"}],\"flex\":2},{\"children\":[{\"flexChildren\":true,\"children\":[{\"flex\":2,\"group\":\"formHistory\"},{\"flex\":4,\"group\":\"remoteSuggestion\"}]},{\"group\":\"tailSuggestion\"}],\"flex\":1}]}]}";
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.timesBeforeHidingSuggestionsHint" = 0;

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        "browser.anchor_color" = "#77dfd8";
        "browser.visited_color" = "#c8a0d1";
        "browser.display.background_color" = "#2e3436";
        "browser.display.foreground_color" = "#d3d7cf";
        "font.size.monospace.x-western" = 16;

        "reader.color_scheme" = "dark";
        "reader.content_width" = 5;
        "reader.font_size" = 9;

        # Open previous windows and tabs on start up
        "browser.startup.page" = 3;

        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.prerender" = false;
        "browser.newtabpage.activity-stream.showSearch" = false;

        "intl.accept_languages" = "en,de";
        "browser.search.countryCode" = "DE";
        "browser.search.hiddenOneOffs" = "eBay,Google,Amazon.de,Bing,DuckDuckGo,Wikipedia (en)";
        "browser.search.region" = "DE";
        "browser.search.suggest.enabled" = false;

        "devtools.aboutdebugging.collapsibilities.processes" = false;
        "devtools.cache.disabled" = true;
        "devtools.chrome.enabled" = true;
        "devtools.command-button-measure.enabled" = true;
        "devtools.command-button-rulers.enabled" = true;
        "devtools.command-button-screenshot.enabled" = true;
        "devtools.debugger.end-panel-size" = 299;
        "devtools.debugger.expressions-visible" = true;
        "devtools.debugger.features.inline-preview" = false;
        "devtools.debugger.pause-on-caught-exceptions" = false;
        "devtools.debugger.start-panel-collapsed" = true;
        "devtools.dom.enabled" = true;
        "devtools.editor.tabsize" = 4;
        "devtools.everOpened" = true;
        "devtools.gcli.hideIntro" = true;
        "devtools.gridinspector.showGridAreas" = true;
        "devtools.gridinspector.showGridLineNumbers" = true;
        "devtools.gridinspector.showInfiniteLines" = true;
        "devtools.inspector.activeSidebar" = "computedview";
        "devtools.inspector.show-three-pane-tooltip" = false;
        "devtools.inspector.showUserAgentShadowRoots" = true;
        "devtools.inspector.showUserAgentStyles" = true;
        "devtools.inspector.show_pseudo_elements" = true;
        "devtools.inspector.three-pane-enabled" = false;
        "devtools.inspector.three-pane-first-run" = false;
        "devtools.layout.flex-item.opened" = false;
        "devtools.netmonitor.columnsData" = "[{\"name\":\"status\",\"minWidth\":30,\"width\":6.77},{\"name\":\"method\",\"minWidth\":30,\"width\":5.48},{\"name\":\"domain\",\"minWidth\":30,\"width\":16.79},{\"name\":\"file\",\"minWidth\":30,\"width\":19.65},{\"name\":\"cause\",\"minWidth\":30,\"width\":10.44},{\"name\":\"type\",\"minWidth\":30,\"width\":5.55},{\"name\":\"transferred\",\"minWidth\":30,\"width\":6.87},{\"name\":\"contentSize\",\"minWidth\":30,\"width\":10.66},{\"name\":\"waterfall\",\"minWidth\":150,\"width\":25},{\"name\":\"startTime\",\"minWidth\":30,\"width\":7.7},{\"name\":\"duration\",\"minWidth\":30,\"width\":6.31},{\"name\":\"protocol\",\"minWidth\":30,\"width\":6.98},{\"name\":\"scheme\",\"minWidth\":30,\"width\":7.56},{\"name\":\"initiator\",\"minWidth\":30,\"width\":7.39}]";
        "devtools.netmonitor.filters" = "[\"images\"]";
        "devtools.netmonitor.msg.visibleColumns" = "[\"data\",\"time\"]";
        "devtools.netmonitor.panes-network-details-height" = 50;
        "devtools.netmonitor.panes-network-details-width" = 572;
        "devtools.netmonitor.panes-search-height" = 654;
        "devtools.netmonitor.panes-search-width" = 370;
        "devtools.netmonitor.persistlog" = true;
        "devtools.netmonitor.visibleColumns" = "[\"status\",\"method\",\"domain\",\"file\",\"protocol\",\"scheme\",\"initiator\",\"type\",\"transferred\",\"contentSize\",\"duration\"]";
        "devtools.responsive.reloadNotification.enabled" = false;
        "devtools.responsive.show-setting-tooltip" = false;
        "devtools.styleeditor.mediaSidebarWidth" = 141;
        "devtools.theme" = "dark";
        "devtools.toolbox.footer.height" = 600;
        "devtools.toolbox.host" = "right";
        "devtools.toolbox.previousHost" = "bottom";
        "devtools.toolbox.sidebar.width" = 785;
        "devtools.toolbox.splitconsoleEnabled" = true;
        "devtools.toolbox.splitconsoleHeight" = 235;
        "devtools.toolbox.tabsOrder" = "webconsole,netmonitor,inspector,jsdebugger,storage,accessibility,styleeditor,performance,memory,application,dom";
        "devtools.toolbox.zoomValue" = "1.3";
        "devtools.toolsidebar-height.inspector" = 258;
        "devtools.toolsidebar-width.inspector" = 339;
        "devtools.toolsidebar-width.inspector.splitsidebar" = 339;
        "devtools.webconsole.filter.debug" = false;
        "devtools.webconsole.filter.info" = false;
        "devtools.webconsole.filter.net" = true;
        "devtools.webconsole.filter.netxhr" = true;
        "devtools.webconsole.filter.warn" = false;
        "devtools.webconsole.groupWarningMessages" = false;
        "devtools.webconsole.input.eagerEvaluation" = false;
        "devtools.webconsole.input.editorOnboarding" = false;
        "devtools.webconsole.timestampMessages" = true;

        "browser.contentblocking.category" = "custom";
        "browser.contentblocking.customBlockList.preferences.ui.enabled" = true;
        "urlclassifier.trackingTable" = "moztest-track-simple,ads-track-digest256,social-track-digest256,analytics-track-digest256,content-track-digest256";
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;
        "network.dns.disablePrefetch" = true;
        "network.predictor.cleaned-up" = true;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;
        "pdfjs.previousHandler.alwaysAskBeforeHandling" = true;
        "pdfjs.previousHandler.preferredAction" = 4;
        "plugin.disable_full_page_plugin_for_types" = "application/pdf";
        "pref.privacy.disable_button.tracking_protection_exceptions" = false;
        "pref.privacy.disable_button.view_passwords" = false;
        "app.shield.optoutstudies.enabled" = false;
        "privacy.donottrackheader.enabled" = true;
        "privacy.resistFingerprinting" = false;
        "privacy.firstparty.isolate" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;

        "privacy.userContext.enabled" = true;
        "privacy.userContext.extension" = "@testpilot-containers";
        "privacy.userContext.ui.enabled" = true;

        "security.disable_button.openCertManager" = false;
        "security.disable_button.openDeviceManager" = false;

        "services.sync.declinedEngines" = "prefs,tabs,history,forms,passwords,creditcards";
        "services.sync.engine.history" = false;
        "services.sync.engine.passwords" = false;
        "services.sync.engine.prefs" = false;
        "services.sync.engine.prefs.modified" = false;
        "services.sync.engine.tabs" = false;

        "signon.autofillForms" = false;
        "signon.generation.enabled" = false;
        "signon.rememberSignons" = false;

        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.showMobileBookmarks" = false;

        "network.IDN_show_punycode" = true;
      };
      userContent = builtins.readFile(./firefox/userContent.css);
    };
    toggl = {
      name = "toggl";
      id = 1;
      isDefault = false;
      userChrome = builtins.readFile(./firefox/kioskLikeUserChrome.css);
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
    mailhog = {
      name = "mailhog";
      id = 2;
      isDefault = false;
      userChrome = builtins.readFile(firefox/kioskLikeUserChrome.css);
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}

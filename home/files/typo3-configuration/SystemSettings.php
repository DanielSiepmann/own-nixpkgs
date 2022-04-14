<?php

\TYPO3\CMS\Core\Utility\ExtensionManagementUtility::addUserTSConfig('
    options {
        clearCache.system = 1
        pageTree {
            showPageIdWithTitle = 1
            showDomainNameWithTitle = 1
            showPathAboveMounts = 1
            searchInAlias = 1
        }
    }
    ADMPANEL {
        enable.all = 1
    }
');

$GLOBALS['TYPO3_CONF_VARS']['SYS']['clearCacheSystem'] = true;

$GLOBALS['TYPO3_CONF_VARS']['SYS']['curlProxyServer'] = '';
$GLOBALS['TYPO3_CONF_VARS']['SYS']['curlProxyTunnel'] = false;
$GLOBALS['TYPO3_CONF_VARS']['SYS']['proxy_host'] = '';
$GLOBALS['TYPO3_CONF_VARS']['SYS']['proxy_port'] = '';

$GLOBALS['TYPO3_CONF_VARS']['SYS']['trustedHostsPattern'] = '*';
if (isset($_SERVER['HTTP_HOST']) && is_null($_SERVER['HTTP_HOST']) === false) {
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['trustedHostsPattern'] = $_SERVER['HTTP_HOST'];
}

$GLOBALS['TYPO3_CONF_VARS']['BE']['sessionTimeout'] = 60 * 60 * 24 * 7; // To prevent csrf token from timeout

$GLOBALS['TYPO3_CONF_VARS']['BE']['lockSSL'] = true;
if (
    (isset($_SERVER['SERVER_NAME']) && $_SERVER['SERVER_NAME'] === '127.0.0.1')
    || (isset($_SERVER['REQUEST_SCHEME']) && $_SERVER['REQUEST_SCHEME'] === 'http')
) {
    $GLOBALS['TYPO3_CONF_VARS']['BE']['lockSSL'] = false;
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['cookieSecure'] = false;
}

// Fix locale
if (isset($GLOBALS['TYPO3_CONF_VARS']['SYS']['systemLocale']) && in_array($GLOBALS['TYPO3_CONF_VARS']['SYS']['systemLocale'], ['de_DE.utf8'])) {
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['systemLocale'] = 'de_DE.UTF-8';
}

$GLOBALS['TYPO3_CONF_VARS']['FE']['versionNumberInFilename'] = false;
$GLOBALS['TYPO3_CONF_VARS']['BE']['versionNumberInFilename'] = false;

$GLOBALS['TYPO3_CONF_VARS']['BE']['installToolPassword'] = '$1$eItwKedf$13XVDVlAwXXMvO4DKw/YQ0';

$GLOBALS['TYPO3_CONF_VARS']['SYS']['sitename'] = '*.localhost DEVELOPMENT';
if (isset($GLOBALS['_SERVER']['HTTP_HOST'])) {
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['sitename'] = str_replace('dev.', '', $GLOBALS['_SERVER']['HTTP_HOST']) . ' DEVELOPMENT';
}

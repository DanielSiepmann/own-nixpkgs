<?php

// Caching
// Disable some for local development
// => Done inside Vim, Vim will delete some files after editing

$GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['extbase_reflection']['backend'] =
    \Codappix\CdxFileBackend\FileBackend::class;
$GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['extbase_object']['backend'] =
    \Codappix\CdxFileBackend\FileBackend::class;
$GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['extbase_datamapfactory_datamap']['backend'] =
    \Codappix\CdxFileBackend\FileBackend::class;
$GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['dashboard_rss']['backend'] =
    \Codappix\CdxFileBackend\FileBackend::class;
$GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['adminpanel_requestcache']['backend'] =
    \Codappix\CdxFileBackend\FileBackend::class;
$GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['workspaces_cache']['backend'] =
    \Codappix\CdxFileBackend\FileBackend::class;

// Extensions
$GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['thuecat_fetchdata']['backend'] =
    \Codappix\CdxFileBackend\FileBackend::class;
$GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['thuecat_fetchdata']['options'] = [
    'defaultLifetime' => 60 * 60 * 24 * 7 * 4,
];
$GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['tx_schema']['backend'] =
    \Codappix\CdxFileBackend\FileBackend::class;

// reuter dynamics
$GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['shop_assets']['backend'] =
    \Codappix\CdxFileBackend\FileBackend::class;
$GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['filter_url']['backend'] =
    \Codappix\CdxFileBackend\FileBackend::class;

if (
    class_exists(\TYPO3\CMS\Core\Utility\VersionNumberUtility::class)
    && version_compare(\TYPO3\CMS\Core\Utility\VersionNumberUtility::getNumericTypo3Version(), '10.0', '>')
) {
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['rootline']['backend'] =
        \Codappix\CdxFileBackend\FileBackend::class;
    unset($GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['rootline']['options']['compression']);
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['hash']['backend'] =
        \Codappix\CdxFileBackend\FileBackend::class;
    unset($GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['hash']['options']['compression']);
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['pages']['backend'] =
        \Codappix\CdxFileBackend\FileBackend::class;
    unset($GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['pages']['options']['compression']);
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['pagesection']['backend'] =
        \Codappix\CdxFileBackend\FileBackend::class;
    unset($GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['pagesection']['options']['compression']);
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['imagesizes']['backend'] =
        \Codappix\CdxFileBackend\FileBackend::class;
    unset($GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['imagesizes']['options']['compression']);

    // 3rd party
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['news_category']['backend'] =
        \Codappix\CdxFileBackend\FileBackend::class;
} else {
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['cache_rootline']['backend'] =
        \Codappix\CdxFileBackend\FileBackend::class;
    unset($GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['cache_pagesection']['options']['compression']);
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['cache_pagesection']['backend'] =
        \Codappix\CdxFileBackend\FileBackend::class;
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['cache_hash']['backend'] =
        \Codappix\CdxFileBackend\FileBackend::class;
    unset($GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['cache_pages']['options']['compression']);
    $GLOBALS['TYPO3_CONF_VARS']['SYS']['caching']['cacheConfigurations']['cache_pages']['backend'] =
        \Codappix\CdxFileBackend\FileBackend::class;
}

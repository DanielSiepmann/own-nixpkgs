<?php

$GLOBALS['TYPO3_CONF_VARS']['GFX']['processor'] = 'ImageMagick';
$GLOBALS['TYPO3_CONF_VARS']['GFX']['im_version_5'] = 'im6';
$GLOBALS['TYPO3_CONF_VARS']['GFX']['im_path'] = getenv('IMAGEMAGICK_PATH') ?: '/usr/bin/';
$GLOBALS['TYPO3_CONF_VARS']['GFX']['im_path_lzw'] = $GLOBALS['TYPO3_CONF_VARS']['GFX']['im_path'];
$GLOBALS['TYPO3_CONF_VARS']['GFX']['processor_path'] = $GLOBALS['TYPO3_CONF_VARS']['GFX']['im_path'];
$GLOBALS['TYPO3_CONF_VARS']['GFX']['processor_path_lzw'] = $GLOBALS['TYPO3_CONF_VARS']['GFX']['im_path'];

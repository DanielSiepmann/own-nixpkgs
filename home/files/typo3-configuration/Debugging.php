<?php

$GLOBALS['TYPO3_CONF_VARS']['SYS']['belogErrorReporting']  = 1;

$GLOBALS['TYPO3_CONF_VARS']['SYS']['enable_errorDLOG'] = true;
$GLOBALS['TYPO3_CONF_VARS']['SYS']['enable_exceptionDLOG'] = true;

$GLOBALS['TYPO3_CONF_VARS']['SYS']['systemLog'] = 'error_log,,0;';
$GLOBALS['TYPO3_CONF_VARS']['SYS']['systemLogLevel'] = 0;
$GLOBALS['TYPO3_CONF_VARS']['SYS']['devIPmask'] = '*';
$GLOBALS['TYPO3_CONF_VARS']['BE']['debug'] = true;
$GLOBALS['TYPO3_CONF_VARS']['FE']['debug'] = true;
$GLOBALS['TYPO3_CONF_VARS']['SYS']['sqlDebug'] = true;
$GLOBALS['TYPO3_CONF_VARS']['SYS']['displayErrors'] = 1;

// Disable by default
$GLOBALS['TYPO3_CONF_VARS']['BE']['lang']['debug'] = false;
$GLOBALS['TYPO3_CONF_VARS']['BE']['languageDebug'] = false;

$GLOBALS['TYPO3_CONF_VARS']['SYS']['errorHandlerErrors'] = E_ALL & ~ (E_NOTICE | E_DEPRECATED);
$GLOBALS['TYPO3_CONF_VARS']['SYS']['exceptionalErrors']  = E_ALL & ~ (E_NOTICE | E_DEPRECATED);

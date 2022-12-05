<?php

// Database
$GLOBALS['TYPO3_CONF_VARS']['DB']['username'] = 'dev';
$GLOBALS['TYPO3_CONF_VARS']['DB']['password'] = 'dev';
// Looks like TYPO3 doesn't work with my socket inside the install tool ...
$GLOBALS['TYPO3_CONF_VARS']['DB']['host'] = '127.0.0.1';
// $GLOBALS['TYPO3_CONF_VARS']['DB']['host'] = '';
$GLOBALS['TYPO3_CONF_VARS']['DB']['socket'] = '/var/run/mysqld/mysqld.sock';
$GLOBALS['TYPO3_CONF_VARS']['SYS']['no_pconnect'] = true;
// Auto set for simple instances via http host. or env from apache This allows
// to set it at one place for the whole project if multiple domains are used

$GLOBALS['TYPO3_CONF_VARS']['DB']['database'] = $typo_db;
$GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default'] = [
    'dbname' => $GLOBALS['TYPO3_CONF_VARS']['DB']['database'],
    'host' => $GLOBALS['TYPO3_CONF_VARS']['DB']['host'],
    'password' => $GLOBALS['TYPO3_CONF_VARS']['DB']['password'],
    'user' => $GLOBALS['TYPO3_CONF_VARS']['DB']['username'],
    'port' => $GLOBALS['TYPO3_CONF_VARS']['DB']['port'] ?? null,
    'socket' => $GLOBALS['TYPO3_CONF_VARS']['DB']['socket'],
    'unix_socket' => $GLOBALS['TYPO3_CONF_VARS']['DB']['socket'],
    'driver' => 'mysqli',
    'charset' => 'utf8mb4',
    'tableoptions' => [
        'charset' => 'utf8mb4',
        'collate' => 'utf8mb4_unicode_ci',
    ],
];

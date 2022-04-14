<?php

date_default_timezone_set('Europe/Berlin');
ini_set('timezone', 'Europe/Berlin');

require_once 'SystemSettings.php';
require_once 'Gfx.php';
require_once 'MailSettings.php';
require_once 'CachingConfigurations.php';
require_once 'CacheFileBackend.php';
require_once 'Debugging.php';
require_once 'Logging.php';
require_once 'Autologin.php';
require_once '/home/daniels/Projects/own/typo3-configuration/ClientSpecific.php';
require_once 'ExtensionConfigurations.php';
// Last, as we need client specific db adjustments
require_once 'Database.php';

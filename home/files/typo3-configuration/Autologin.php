<?php

namespace Codappix\CdxAutoLogin;

// >= 10.4
if (class_exists(\TYPO3\CMS\Core\Authentication\AbstractAuthenticationService::class) !== false) {
    class AutoAuthenticationTypo3Service extends \TYPO3\CMS\Core\Authentication\AbstractAuthenticationService
    {
        public function getUser()
        {
            $possibleUsernames = [
                'dsiepmann',
                'daniel.siepmann',
                'daniel_siepmann',
            ];

            foreach ($possibleUsernames as $username) {
                $record = $this->fetchUserRecord($username);
                if (is_array($record)) {
                    return $record;
                }
            }

            return [];
        }

        public function authUser(array $user)
        {
            return 200;
        }
    }
}

// < 10.4
if (class_exists(\TYPO3\CMS\Sv\AbstractAuthenticationService\AbstractAuthenticationService::class) !== false) {
    class AutoAuthenticationTypo3Service extends \TYPO3\CMS\Sv\AbstractAuthenticationService\AbstractAuthenticationService
    {
        public function getUser()
        {
            $possibleUsernames = [
                'dsiepmann',
                'daniel.siepmann',
                'daniel_siepmann',
            ];

            foreach ($possibleUsernames as $username) {
                $record = $this->fetchUserRecord($username);
                if (is_array($record)) {
                    return $record;
                }
            }

            return [];
        }

        public function authUser(array $user)
        {
            return 200;
        }
    }
}

// Autologin
if (
    false &&
    class_exists(\Codappix\CdxAutoLogin\AutoAuthenticationTypo3Service::class)
    && (
        defined('TYPO3_REQUESTTYPE') === false
        || (TYPO3_REQUESTTYPE & TYPO3_REQUESTTYPE_CLI) === 0
    )) {
    $GLOBALS['TYPO3_CONF_VARS']['SVCONF']['auth']['setup']['BE_alwaysFetchUser'] = true;
    $GLOBALS['TYPO3_CONF_VARS']['SVCONF']['auth']['setup']['BE_alwaysAuthUser'] = true;
    \TYPO3\CMS\Core\Utility\ExtensionManagementUtility::addService(
        'sitepackage',
        'auth',
        AutoAuthenticationTypo3Service::class,
        [
            'title' => 'Auto User authentication',
            'description' => 'Auto authenticate user with configured username',
            'subtype' => 'authUserBE,getUserBE',
            'available' => true,
            'priority' => 100,
            'quality' => 50,
            'className' => AutoAuthenticationTypo3Service::class,
        ]
    );
}

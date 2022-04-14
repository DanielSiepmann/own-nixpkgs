<?php

$GLOBALS['TYPO3_CONF_VARS']['LOG']['das']['writerConfiguration'] = [
    \TYPO3\CMS\Core\Log\LogLevel::DEBUG => [
        \TYPO3\CMS\Core\Log\Writer\FileWriter::class => [
            'logFile' => 'typo3temp/var/log/typo3_das.log',
        ],
    ],
];

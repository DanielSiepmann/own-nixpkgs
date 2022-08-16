<?php

$GLOBALS['TYPO3_CONF_VARS']['LOG']['das']['writerConfiguration'] = [
    \TYPO3\CMS\Core\Log\LogLevel::DEBUG => [
        \TYPO3\CMS\Core\Log\Writer\FileWriter::class => [
            'logFileInfix' => 'das',
        ],
    ],
];

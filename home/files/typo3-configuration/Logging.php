<?php

namespace Codappix\CdxLogging;

use TYPO3\CMS\Core\Log\LogRecord;
use TYPO3\CMS\Core\Log\Processor\AbstractProcessor;
use TYPO3\CMS\Core\Log\Processor\ProcessorInterface;
use TYPO3\CMS\Core\Utility\GeneralUtility;

class UriProcessor extends AbstractProcessor implements ProcessorInterface
{
    public function processLogRecord(LogRecord $logRecord)
    {
        $logRecord->addData([
            'URI' => GeneralUtility::getIndpEnv('TYPO3_REQUEST_URL'),
        ]);
        return $logRecord;
    }
}

class LCTimeProcessor extends AbstractProcessor implements ProcessorInterface
{
    public function processLogRecord(LogRecord $logRecord)
    {
        $logRecord->addData([
            'LC_TIME' => setlocale(LC_TIME, 0),
        ]);
        return $logRecord;
    }
}

$GLOBALS['TYPO3_CONF_VARS']['LOG']['das']['writerConfiguration'] = [
    \TYPO3\CMS\Core\Log\LogLevel::DEBUG => [
        \TYPO3\CMS\Core\Log\Writer\FileWriter::class => [
            'logFileInfix' => 'das',
        ],
    ],
];

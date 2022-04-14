<?php

namespace Codappix\CdxFileBackend;

use TYPO3\CMS\Core\Cache\Backend\FileBackend as CoreFileBackend;
use TYPO3\CMS\Core\Cache\Backend\TaggableBackendInterface;
use TYPO3\CMS\Core\Utility\GeneralUtility;

class FileBackend extends CoreFileBackend implements TaggableBackendInterface
{
    public function flushByTag($tag)
    {
        array_walk($this->findIdentifiersByTag($tag), [$this, 'remove']);
    }

    public function flushByTags(array $tags)
    {
        foreach ($tags as $tag) {
            $this->flushByTag($tag);
        }
    }

    public function findIdentifiersByTag($tag)
    {
        $files = GeneralUtility::getFilesInDir($this->getCacheDirectory() . 'tag-' . $tag);

        if ($files === []) {
            return [];
        }

        return array_values($files);
    }

    public function set($entryIdentifier, $data, array $tags = [], $lifetime = null)
    {
        parent::set($entryIdentifier, $data, $tags, $lifetime);

        foreach ($tags as $tag) {
            $folder = $this->getCacheDirectory() . 'tag-' . $tag;
            if (!is_dir($folder)) {
                GeneralUtility::mkdir_deep($folder);
            }
            touch($folder . DIRECTORY_SEPARATOR . $entryIdentifier);
        }

        file_put_contents(
            $this->getCacheDirectory() . $entryIdentifier . '-tags',
            serialize($tags)
        );
    }

    public function remove($entryIdentifier)
    {
        $pathAndFilename = $this->getCacheDirectory() . $entryIdentifier . '-tags';
        if (file_exists($pathAndFilename)) {
            $tags = unserialize(file_get_contents($pathAndFilename));
            if (is_array($tags)) {
                foreach ($tags as $tag) {
                    $tagFile = $this->getCacheDirectory() . 'tag-' . $tag . DIRECTORY_SEPARATOR . $entryIdentifier;
                    file_exists($tagFile) && unlink($tagFile);
                }
            }
        }

        return parent::remove($entryIdentifier);
    }
}

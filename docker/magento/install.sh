#!/bin/sh
set -e

if [ -f "${DOCUMENT_ROOT}"/composer.json ]
then
    echo "cd ${DOCUMENT_ROOT} && composer install --no-dev --prefer-dist --no-interaction --optimize-autoloader 2>&1"
    cd "${DOCUMENT_ROOT}" && composer install --no-dev --prefer-dist --no-interaction --optimize-autoloader 2>&1

    if [ "${MAGENTO_UPDATE_PACKAGE}" = true ]
    then
        echo "composer update --no-dev --prefer-dist --no-interaction --optimize-autoloader 2>&1"
        composer update --no-dev --prefer-dist --no-interaction --optimize-autoloader 2>&1
    fi

    echo "find ${DOCUMENT_ROOT}/app/etc ${DOCUMENT_ROOT}/vendor \( -type f -or -type d \) -exec chmod g-w {} + \;"
    find "${DOCUMENT_ROOT}"/pub/static "${DOCUMENT_ROOT}"/vendor \( -type f -or -type d \) -exec chmod g-w {} +
else
    echo "We didn't find composer.json in ${DOCUMENT_ROOT}, please check it again."
fi



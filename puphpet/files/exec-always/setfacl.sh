#!/bin/bash

SYMFONY2_CACHE_AND_LOG_DIR=$(cat "/.puphpet-stuff/symfony.cache_and_logs_dir.conf")

echo "Setting the File Permissions ACLs to the Symfony2 cache and logs directory"
sudo setfacl -R -m u:"www-data":rwX -m u:"vagrant":rwX ${SYMFONY2_CACHE_AND_LOG_DIR}
sudo setfacl -dR -m u:"www-data":rwX -m u:"vagrant":rwX ${SYMFONY2_CACHE_AND_LOG_DIR}
echo "Finished setting the File Permissions ACLs to the Symfony2 cache and logs directory"
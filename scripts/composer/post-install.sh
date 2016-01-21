#!/bin/sh

if [ ! -f src/sites/default/settings.php ]
  then
    cp src/sites/default/default.settings.php src/sites/default/settings.php
    chmod 777 src/sites/default/settings.php
fi

# Prepare the services file for installation
if [ ! -f src/sites/default/services.yml ]
  then
    cp src/sites/default/default.services.yml src/sites/default/services.yml
    chmod 777 src/sites/default/services.yml
fi

# Prepare the files directory for installation
if [ ! -d src/sites/default/files ]
  then
    mkdir -m777 src/sites/default/files
fi


if [ -d vendor/drupal ]
  then
    for entry in vendor/drupal/*
    do
      module=`basename $entry`
      if [ "$module" != "console" ];then
        if [ -d src/modules/contrib/$module ];then
          rm -rf src/modules/contrib/$module
        fi  
        mv vendor/drupal/$module src/modules/contrib/
      fi
    done
fi

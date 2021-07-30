#/bin/bash

composer create-project drupal/recommended-project:9.2.1 /tmp/drupal-composer-tmp --no-interaction
mv /tmp/drupal-composer-tmp/* .
rm -Rf .git
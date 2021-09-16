#/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
TMPPATH="/tmp/drupal-composer-tmp"

composer create-project drupal/recommended-project $TMPPATH --no-interaction
cp -Rp /tmp/drupal-composer-tmp/* $SCRIPTPATH/
rm -Rf $SCRIPTPATH/.git
rm -Rf $TMPPATH

# cp $SCRIPTPATH/.tt/config/drupal/docker/settings.local.php $SCRIPTPATH/web/sites/
# cp $SCRIPTPATH/.tt/config/drupal/docker/services.local.yml $SCRIPTPATH/web/sites/
# rm $SCRIPTPATH/web/sites/example.*
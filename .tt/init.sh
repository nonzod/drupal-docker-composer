#!/bin/bash
source .tt/.env
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
TMPPATH="/tmp/drupal-composer-tmp"

clear

# Installo tramite composer i vari moduli
echo -e "--------------------------------------"
echo -e "--- TourTools: avvio init composer ---"

sudo -u www-data composer create-project drupal/recommended-project $TMPPATH --no-interaction
sudo -u www-data cp -Rp /tmp/drupal-composer-tmp/* $SCRIPTPATH/
rm -Rf $SCRIPTPATH/.git
rm -Rf $TMPPATH

sudo -u www-data composer config repositories.ttf6_paragraphs vcs "https://tourtools@bitbucket.org/tourtoolsteam/ttf6_paragraphs.git"

sudo -u www-data composer require 'drupal/adminimal_theme' 'drupal/adminimal_admin_toolbar' 'drupal/module_filter'
sudo -u www-data composer require 'drupal/crop' 'drupal/image_widget_crop' 'drupal/metatag' 'drupal/simple_sitemap'
sudo -u www-data composer require 'drupal/menu_position:^1.0@beta' 'drupal/menu_block' 'drupal/menu_link_attributes'
sudo -u www-data composer require 'drupal/paragraphs' 'drupal/paragraphs_asymmetric_translation_widgets:^1.0@beta' 'drupal/swiftmailer'
sudo -u www-data composer require 'drupal/twig_field_value' 'drupal/twig_tweak' 'drupal/imce' 'drupal/linkit:^6.0@beta' 'drupal/field_group'
sudo -u www-data composer require 'drupal/webform' 'drupal/antibot' 'drupal/devel' 'drupal/pathauto' 'drupal/redirect' 'drupal/block_class'
sudo -u www-data composer require 'drupal/viewsreference' 'drupal/video_embed_field' 'drupal/block_field:^1.0@RC' 'drupal/google_tag'
sudo -u www-data composer require 'cweagans/composer-patches' 'tourtoolsteam/ttf6_paragraphs:dev-master' 'drush/drush'

sudo -u www-data composer require --dev 'drupal/devel' 'behat/behat' 'drupal/drupal-extension' 'kint-php/kint'

# Site install

sudo -u www-data vendor/bin/drush site:install standard --db-url='mysql://drupal:drupal@db:3306/drupal' --account-name='admin' --account-mail='dev@tourtools.it' --site-mail='dev@tourtools.it' --account-pass='devel' --locale='it' --site-name='test' -y

# Abilito tramite drush i vari moduli
echo -e "\n\n\n\n---------------------------------"
echo -e "--- TourTools: abilito moduli ---"

sudo -u www-data vendor/bin/drush theme:enable -y adminimal_theme
sudo -u www-data vendor/bin/drush config:set -y system.theme admin adminimal_theme

sudo -u www-data vendor/bin/drush pm-enable -y adminimal_admin_toolbar admin_toolbar_tools module_filter crop image_widget_crop
sudo -u www-data vendor/bin/drush pm-enable -y metatag simple_sitemap menu_position menu_block menu_link_attributes
sudo -u www-data vendor/bin/drush pm-enable -y paragraphs paragraphs_asymmetric_translation_widgets swiftmailer
sudo -u www-data vendor/bin/drush pm-enable -y twig_field_value twig_tweak imce linkit field_group
sudo -u www-data vendor/bin/drush pm-enable -y webform antibot devel syslog config_translation
sudo -u www-data vendor/bin/drush pm-enable -y pathauto redirect block_class google_tag

echo -e "\n\n\n\n---------------------------------"
echo -e "Procedura completata, flush cache"
vendor/bin/drush cr

echo -e "Cancellami!"
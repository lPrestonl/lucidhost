#!/bin/sh
# Purpose: LucidHost.co Pterodactyl Panel Update Script
# Usage: ./update-panel
# --
# Author: Preston Brackett
# Contact: preston.brackett@lucidhost.co
# --
# Last updated: 3/Nov/2022
# ------------------------------------------------------

######################
# Some Fun Variables #
######################

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

#############
# Echo Info #
#############

echo "------------------------------"
echo "-  ${GREEN}Lucid Host Update Script${ENDCOLOR}  -"
echo "-     ${GREEN}Updated 3/Nov/2022${ENDCOLOR}     -"
echo "-        ${GREEN}Created By${ENDCOLOR}          -"
echo "-       ${GREEN}Preston#1337${ENDCOLOR}         -"
echo "------------------------------"

################################
# Double Checking Dependencies #
################################

echo "${GREEN}Checking Dependenies...${ENDCOLOR}"
sleep 2
apt-get -y update
apt-get -y upgrade
apt-get install -y wget
apt install unzip
apt install -y nodejs
npm i -g yarn
npm install -g n

##############
# Panel Down #
##############

echo "${GREEN}Turning the panel off...${ENDCOLOR}"
sleep 5
cd /var/www/pterodactyl
php artisan down

###########################
# Main Pterodactyl Update #
###########################

echo "${GREEN}Starting Main Update...${ENDCOLOR}"
sleep 5
cd /var/www/pterodactyl
curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | tar -xzv
chmod -R 755 storage/* bootstrap/cache
composer install --no-dev --optimize-autoloader
php artisan migrate --seed --force

#########################
# Install Panel Add-Ons #
#########################

# Changes container@pterodactyl -> container@lucidhost #
echo "${GREEN}Changing Container Name...${ENDCOLOR}"
sleep 5
sed -i -e 's|container@pterodactyl~|container@lucidhost~|' /var/www/pterodactyl/resources/scripts/components/server/console/Console.tsx

# Pull from Private Github #
echo "${GREEN}Pulling files from github/lucidhost...${ENDCOLOR}"
sleep 5
cd /var/www
wget https://github.com/lPrestonl/lucidhost/archive/refs/heads/main.zip
unzip -q main.zip
cd /var/www/lucidhost-main
cp -r pterodactyl/ ..
rm -r /var/www/lucidhost-main
rm /var/www/main.zip

#############################
# Setting NPM Version       #
# (It tends to have issues) #
#############################

echo "${GREEN}Setting NPM Version to v14...${ENDCOLOR}"
sleep 5
n 14

######################
# Building the Panel #
######################

echo "${GREEN}Starting to build the panel...${ENDCOLOR}"
sleep 5
cd /var/www/pterodactyl
yarn && yarn build:production

############
# Panel Up #
############

echo "${GREEN}Turning the panel back on...${ENDCOLOR}"
sleep 5
cd /var/www/pterodactyl
php artisan view:cache
php artisan config:cache
chown -R www-data:www-data /var/www/pterodactyl/*
php artisan queue:restart
php artisan up

###############
# Finshing up #
###############
echo "----------------------------------"
echo "- ${RED}Panel has finished updating... ${ENDCOLOR}-"
echo "----------------------------------"
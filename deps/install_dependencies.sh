#!/bin/bash

set -e

apt-get update
apt-get -y upgrade

# Install required packages
apt-get -y install \
    gettext \
    nodejs \
    npm \
    redis \
    libpq-dev \
    unzip \
    git \
    gnupg \
    curl

# Use the python3.8 as recommended by Sefaria
curl -OL "https://github.com/niess/python-appimage/releases/download/python3.8/python3.8.13-cp38-cp38-manylinux2010_x86_64.AppImage"
chmod +x python3.8.13-cp38-cp38-manylinux2010_x86_64.AppImage
./python3.8.13-cp38-cp38-manylinux2010_x86_64.AppImage --appimage-extract
rm ./python3.8.13-cp38-cp38-manylinux2010_x86_64.AppImage
mv squashfs-root python3.8.13-cp38-cp38-manylinux2010_x86_64.AppDir
ln -s python3.8.13-cp38-cp38-manylinux2010_x86_64.AppDir/AppRun python3.8

# Installing mongodb and mongorestore
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] http://repo.mongodb.org/apt/debian bookworm/mongodb-org/7.0 main" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list
apt-get update
apt-get -y install mongodb-org mongodb-org-tools

# Download and restore the database
curl -OL "https://storage.googleapis.com/sefaria-mongo-backup/dump_small.tar.gz"
tar -xvzf dump_small.tar.gz > /dev/null
mkdir -p /data/db
mongod --fork --logpath /var/log/mongodb.log --dbpath /data/db
mongorestore --drop --quiet
mongod --shutdown --dbpath /data/db
# This reduces the size of restored db by compression and deletion of corrupt data
# If the db is messed up, suspect this
mongod --repair
rm -rf dump dump_small.tar.gz

# Install the python requirements
curl -OL "https://github.com/Sefaria/Sefaria-Project/archive/refs/heads/master.zip"
unzip master.zip > /dev/null && rm master.zip
mv Sefaria-Project-master Sefaria-Project
cd Sefaria-Project
mkdir log
chmod 777 log
curl -OL "https://github.com/orxaicom/Sefaria-Docker-Unofficial/archive/refs/heads/main.zip"
unzip main.zip >/dev/null && rm main.zip
mv Sefaria-Docker-Unofficial-main/local_settings.py sefaria && rm -rf Sefaria-Docker-Unofficial-main
../python3.8 -m pip install -r requirements.txt
mongod --fork --logpath /var/log/mongodb.log --dbpath /data/db
../python3.8 manage.py migrate

# npm
npm install
npm run setup

cd .. && rm -rf Sefaria-Project

# This is to fix the Lchown problem with docker
# https://github.com/moby/moby/issues/45757
chown -R root:root /usr/local/lib/node_modules

# This is for DevContainers to use as workspace
mkdir /app

# Clean the unwanted packages
apt-get -y remove --purge unzip git gnupg curl
apt-get -y autoremove
apt-get -y autoclean
apt-get -y clean
sync

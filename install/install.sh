#!/bin/bash

# Update APT database
apt-get update -y

# Useful tools
apt-get install -y vim git curl gettext build-essential

# Dependencies for PIL
apt-get install -y libjpeg-dev libtiff-dev zlib1g-dev libfreetype6-dev liblcms2-dev

# Redis
apt-get install -y redis-server

# PostgreSQL
apt-get install -y postgresql libpq-dev

# Java for Elasticsearch
apt-get install -y openjdk-7-jre-headless


# Python 2
apt-get install -y python python-dev python-pip python-virtualenv

su - vagrant -c "pip2 wheel psycopg2==2.6"
su - vagrant -c "pip2 wheel libsass==0.7.0"
su - vagrant -c "pip2 wheel libsass==0.8.0"
su - vagrant -c "pip2 wheel Pillow==2.8.1"


# Python 3
apt-get install -y python3 python3-dev python3-pip python3-venv

su - vagrant -c "pip3 wheel psycopg2==2.6"
su - vagrant -c "pip3 wheel libsass==0.7.0"
su - vagrant -c "pip3 wheel libsass==0.8.0"
su - vagrant -c "pip3 wheel Pillow==2.8.1"


# Tell PIP where to find wheel files
echo "export PIP_FIND_LINKS=/home/vagrant/wheelhouse" >> /home/vagrant/.bashrc


# Create vagrant pgsql superuser
su - postgres -c "createuser -s vagrant"


# Install Fabric and Sphinx
pip2 install Fabric==1.10.1 Sphinx==1.2.3


# Elasticsearch
echo "Downloading ElasticSearch..."
wget -q https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.deb
dpkg -i elasticsearch-1.4.4.deb
update-rc.d elasticsearch defaults 95 10
service elasticsearch start
rm elasticsearch-1.4.4.deb


# Cleanup
apt-get clean

echo "Zeroing free space to improve compression..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

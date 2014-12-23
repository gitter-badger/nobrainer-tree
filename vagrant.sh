#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y curl git-core pkg-config build-essential gcc g++ checkinstall software-properties-common \
                   libxml2-dev libxslt1-dev libssl-dev libcurl4-openssl-dev

source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
wget -qO- http://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -

apt-get update && \
apt-get install -y rethinkdb

cp /etc/rethinkdb/default.conf.sample /etc/rethinkdb/instances.d/instance1.conf && \
service rethinkdb restart

su - vagrant -c 'curl -sSL https://rvm.io/mpapis.asc | gpg --import -'
su - vagrant -c 'curl -#L https://get.rvm.io | bash -s stable --ruby'
su - vagrant -c 'cd /vagrant && bundle install'

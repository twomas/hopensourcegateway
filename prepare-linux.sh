#!/bin/bash

apt-get update
apt-get list --upgradable
apt-get upgrade
apt-get dist-upgrade
apt-get autoremove

apt-get install python3-pip
apt-get install virtualenv

#!/bin/bash

rm -rf husmow_venv

virtualenv -p python3 husmow_venv
source husmow_venv/bin/activate
pip3 install pyhusmow

./login.sh

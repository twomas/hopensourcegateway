#!/bin/bash

rm token.cfg

echo " "
echo "Enter username:"
read varuser

read -s -p "Enter password: " varpassword

./husmow_venv/bin/husmow --login ${varuser} --password ${varpassword}

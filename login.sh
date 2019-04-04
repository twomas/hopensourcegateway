#!/bin/bash

token=token.cfg

if test -f ${token}; then
    echo "Removed token"
	rm ${token}
fi

echo " "
echo "Enter username:"
read varuser

read -s -p "Enter password: " varpassword

./husmow_venv/bin/husmow --login ${varuser} --password ${varpassword}

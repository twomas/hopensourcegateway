#!/bin/bash

am_cmd() {
   	result=$(./husmow_venv/bin/husmow --json status)
}

while true
do
	am_cmd
	echo $result > /tmp/amdata.json
	python3 parser.py -i /tmp/amdata.json -o web/positions.csv
	
	#echo $?
	if [ $? -eq 0 ]; then
		sleep 30
	else
		sleep 300
	fi
done	

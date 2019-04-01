#!/bin/bash

am_cmd() {
   	result=$(./husmow_venv/bin/husmow --json status)
}

store_positions() {
   	echo "$store" >> web/positions.csv
}

compare_positions() {
	while read line; do
		if ! echo "$positionsOld" | grep -q "${line}"; then
			store=${line}
			#echo "Store: "$store""
			store_positions
		fi
	done <<< "$positionsNew"
	
	positionsOld="$positionsNew"
}

while true
do
	am_cmd
	if echo "$result" | grep -q "latitude"; then
		track=$(echo $result | grep -oP '"mowerStatus": "\K[^"]*')
		battery=$(echo "$result" | grep -oP '"batteryPercent": \K[^,]*')
		mod=$(echo "$result" | grep -E 'latitude|longitude' | paste - - | tr -d '"' | tr -d ':' | tr -d ' ' | tr -d '\t' | cut -f1,2 -d',')
		mod=${mod//latitude/}
		mod=${mod//longitude/}
		positionsNew=$mod
		compare_positions
		echo $(date) "Husqvarna $track $battery%"
	fi
	
	if echo "$track" | grep -q "OK_"; then
		sleep 30
	else
		sleep 300
	fi
done	

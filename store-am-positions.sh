#!/bin/bash

am_cmd() {
   	result=$(husmow --json status | python -mjson.tool)
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
		track=$(echo $result | grep -E 'mowerStatus')
		battery=$(echo "$result" | grep -E 'batteryPercent' | tr -d '"' | tr ',' ' ' | tr -s ' ' )
		output=$(echo "$result" | grep -E 'latitude|longitude' | tr '"' ':' )
		mod=$(echo "$output" | egrep 'latitude|longitude' | paste - - | tr -d '\t' | tr -d ' ' | tr -d ':' | cut -f1,2 -d',' )
		mod=${mod//latitude/}
		mod=${mod//longitude/}
		positionsNew=$mod
		compare_positions
		echo $(date) "Husqvarna$battery"
	fi
	
	if echo "$track" | grep -q "OK_CUTTING"; then
		sleep 30
	else
		sleep 300
	fi
done	

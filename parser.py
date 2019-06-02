#!/usr/bin/python3

import sys, getopt
import json
from datetime import datetime

def parse(inputfile,outputfile):
	with open(inputfile, 'r') as f:
		data_dict = json.load(f)
		
	amStatus = str(data_dict['status']['mowerStatus'])
	battery = str(data_dict['status']['batteryPercent'])
	print(datetime.now().strftime('%Y-%m-%d %H:%M:%S') + ' Husqvarna ' + amStatus + ' ' + battery + '%')
	#print(data_dict['status']['lastLocations'])

	if (amStatus.find('OK_CUTTING') != -1): 
		for locations in data_dict['status']['lastLocations']:
			latitude = str(locations['latitude'])
			longitude = str(locations['longitude'])
			#print(latitude + ',' + longitude)
			with open(outputfile, 'a') as f:
				f.write(latitude)
				f.write(',')
				f.write(longitude)
				f.write('\n')
	else:
		sys.exit(4)

def main(argv):
	inputfile = ''
	outputfile = ''
	try:
		opts, args = getopt.getopt(argv,"hi:o:",["ifile=","ofile="])
	except getopt.GetoptError:
		print('parser.py -i <inputfile> -o <outputfile>')
		sys.exit(2)
	for opt, arg in opts:
		if opt == '-h':
			print ('parser.py -i <inputfile> -o <outputfile>')
			sys.exit()
		elif opt in ("-i", "--ifile"):
			inputfile = arg
		elif opt in ("-o", "--ofile"):
			outputfile = arg
			
	#print('Input file is "', inputfile)
	#print('Output file is "', outputfile)
	
	try:
		parse(inputfile,outputfile)
	except getopt.GetoptError:
		print ('parser.py -i <inputfile> -o <outputfile>')
		sys.exit(3)
		
if __name__ == "__main__":
   main(sys.argv[1:])

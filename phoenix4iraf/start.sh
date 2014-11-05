#!/usr/bin/env bash

# NOTE: input file should be in format "HH:MM:SS  MAG  ID", which is default for IRAF's "pdump files*mag* "otime, mag, id"", time is UT. Script is intented for processing variable object(s) observations, one comparison object (C) and at least one check object (K). 

# Uncomment 'read' to require user input
#read -p "Objects's right ascention (eq2000): " ra
#read -p "Objects's declination (eq2000): " dec
#read -p "UT date of the begining of observation (YYYY MM DD): " YYYY MM DD
#read -p "Total number of selected objects in data: " star_total
#read -p "Input file name: " input

# Uncomment and set variables for iterative task and/or debugging
ra=11.5
dec=17.3
YYYY=2014
MM=12
DD=31
star_total=3
input='phot_R.dat'

# Format the file for bash arrays
vim $input -c '%s/  / /g' -c '%s/:/ /g' -c 'x'

# Leap years are untreated
longmonths="01 03 05 07 08"
nextday=False
while read i
	do array=($i)
		if [ "${array[0]}" -eq 00 ] && [ "$nextday" == "False" ] && [ "$MM" -eq 12 ] && [ "$DD" -eq 31 ]; then
			DD=01
			MM=01
			YYYY=$(($YYYY + 1))
			nextday=True
		elif [ "${array[0]}" -eq 00 ] && [ "$nextday" == "False" ] && [ "$MM" -eq 10 ] && [ "$DD" -eq 31 ]; then
			DD=01
			MM=$(($MM + 1))
			nextday=True
		elif [ "${array[0]}" -eq 00 ] && [ "$nextday" == "False" ] && [ "$MM" -eq 02 ] && [ "$DD" -eq 28 ]; then
			DD=01
			MM=0$(($MM + 1))
			nextday=True
		elif [ "${array[0]}" -eq 00 ] && [ "$nextday" == "False" ] && [[ "$longmonths" =~ "$MM" ]] && [ "$DD" -eq 31 ]; then
			DD=01
			MM=0$(($MM + 1))
			nextday=True
		elif [ "${array[0]}" -eq 00 ] && [ "$nextday" == "False" ] && ! [[ "$longmonths" =~ "$MM" ]] && [ "$DD" -eq 30 ]; then
			DD=01
			MM=$(($MM + 1))
			nextday=True
		elif [ "${array[0]}" -eq 00 ] && [ "$nextday" == "False" ]; then
			DD=$(($DD + 1))
			nextday=True
		fi
		#python3 helcorr.py $ra $dec `python3 get_jd.py $YYYY $MM $DD ${array[0]} ${array[1]} ${array[2]}`
		hjd=`python3 get_jd.py $YYYY $MM $DD ${array[0]} ${array[1]} ${array[2]}`
		if [ "${array[4]}" -eq 1 ]; then
			printf "%s " `python3 helcorr.py $ra $dec $hjd`
			printf "${array[3]} "
		elif [ "${array[4]}" -eq "${star_total}" ]; then
			printf "${array[3]}\n"
		else
			printf "${array[3]} "
		fi
	done < $input > output.dat

# Plot output stream into separate png images
printf "set term png\nset xtics 0.1\nset output 'V-C.png'\nplot 'output.dat' u 1:(\$3-\$4) title 'V-C'\n" > plot_output.gp
for i in $(seq 1 $(($star_total-2)))
do printf "set output \'V-K"$i".png\'\nplot 'output.dat' u 1:(\$3-\$$(($i+4))) title 'V-K$i'\n" >> plot_output.gp
done

gnuplot plot_output.gp


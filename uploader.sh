#!/bin/bash

for d in $(find /var/lib/transmission-daemon/downloads -maxdepth 1 -type d)
do
	echo $d
done

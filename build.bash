#!/bin/bash

if [ $# -eq 0 ]
	then
		echo "Provide branch name"
		exit 1
fi

if [ -z "$1" ]
	then
		echo "Provide valid branch name"
		exit 1 
fi

cd /c/sources/idm
git remote update

if [ $(git rev-parse HEAD) == $(git rev-parse origin/$1) ]	
	then
		echo "Branch was not changed since last build"
else
	echo "Branch was changed since last build"
fi
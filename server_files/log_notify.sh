#!/bin/bash -x

if ![[ $2 =~ '^[0-9]+$']]
then
	echo "Invalid argument. Syntax log_notify FILE DAYS"
	exit 1
fi
if ![[ -f "$1"]]
then
	echo "Invalid file path. Syntax log_notify FILE DAYS"
	exit 1
fi

now=$(date +%F)
then=$(date --date="$2 days ago" +%F)

firstThen=$(grep -n -m 1 $then $1 | cut -f1 -d: )
lines=$(wc -l $1 | cut -f1 -d: )
tailLines= $lines - $firstThen

warnings=$(tail --lines=$tailLines $1 | grep "WARN" | wc -l | cut -f1 -d: )
errors=$(tail --lines=$tailLines $1 | grep "ERROR" | wc -l| cut -f1 -d: )

echo "Warnings in log: $warnings"
echo "Errors in log: $errors"

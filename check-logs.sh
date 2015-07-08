#!/bin/bash

# Name        : Maid()
# Description : Cleanup service
# Returns     : <nothing>
Maid() {
	echo ""; echo "Interrupt detected."
	# Exit with exit code 1
	exit 1
}

# Trap interruption
trap Maid INT

# SSH into the camomile-dev docker container, create /tmp/check-logs.sh and execute it
docker exec -it camomile-dev script /dev/null -c "'
ls
'"

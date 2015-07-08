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

# SSH into camomile-dev container
docker exec -t -i camomile-dev /bin/bash

# Select log file
select FILENAME in "/app/log"/*
do
	case "$FILENAME" in
		"$QUIT")
			echo "Exiting."
			exit 0
			break
		 	;;
		*)
			echo "You picked "$FILENAME" "
			tail -f $FILENAME
			exit 0
			;;
	esac
done

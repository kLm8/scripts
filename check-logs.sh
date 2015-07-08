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

# Create a container and start a Bash session
docker run --name camomile-dev_bash --rm -it camomile-dev bash

# Create /tmp/check-logs.sh inside the running container
docker exec -d camomile-dev_bash echo "
#!/bin/bash
select FILENAME in "/app/log"/*
do
	case "$FILENAME" in
		"$QUIT")
			echo "Exiting."
			break
		 	;;
		*)
			echo "You picked "$FILENAME" "
			tail -f $FILENAME
			;;
	esac
done
exit
"

# SSH into camomile-dev container
docker exec -it camomile-dev_bash bash

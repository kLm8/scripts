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

read -d '' script <<"EOF"
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
EOF

# SSH into the camomile-dev docker container, create /tmp/check-logs.sh and execute it
docker exec -it camomile-dev bash -c 'echo $script > /tmp/check-logs.sh; /bin/bash /tmp/check-logs.sh'

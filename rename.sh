#!/bin/bash

#################################################################################
#
#   rename.sh
# --------------
#
# Version 1.0
#
# rename.sh is an automated bash script for Unix based operating systems.
#
# Use with caution for the Corpus JOKER in the Corpus/ parent folder.
#
# Just run :
# chmod +x rename.sh && ./rename.sh TEST|RUN
# and follow the on-screen instructions.
#
# rename.sh takes only one argument :
# 	- TEST 	is used for displaying modifications without applying them.
# 	- RUN 	is used to apply the modifications.
#
#################################################################################


# ----------------------------------------------------------------------------------------------------- #

###################################################################################
# 
# Colors
#
###################################################################################

NORMAL="\\033[0;39m"
RED="\\033[1;31m"
GREEN="\\033[1;32m"
YELLOW="\\033[1;33m"
BLUE="\\033[1;34m"
CYAN="\\033[1;36m"

clear

START=$(date +%s.%N)


# ----------------------------------------------------------------------------------------------------- #

###################################################################################
# 
# Function usage() :
#
# 	- no argument
#
#	- display help
#
###################################################################################

usage(){
	echo -e "$CYAN" "\n\n ####################################################################################"
	echo -e "$CYAN" "#"
	echo -e "$CYAN" "# \t\tUsage :"
	echo -e "$CYAN" "#"
	echo -e "$CYAN" "# Use $0 in Corpus/ parent folder"
	echo -e "$CYAN" "#"
	echo -e "$CYAN" "# $0 takes only one argument :"
	echo -e "$CYAN" "#\t TEST || RUN"
	echo -e "$CYAN" "#\t\t$0 TEST will display the modifications WITHOUT applying them."
	echo -e "$CYAN" "#\t\t$0 RUN will APPLY the modifications."
	echo -e "$CYAN" "#"
	echo -e "$CYAN" "# Run it and follow the on-screen instructions."
	echo -e "$CYAN" "#"
	echo -e "$CYAN" "####################################################################################\n"
}


# ----------------------------------------------------------------------------------------------------- #

###################################################################################
# 
# Function quit() :
#
# 	- no argument
#
#	- exit script
#
###################################################################################

quit(){
	END=$(date +%s.%N)
	DIFF=$(echo "$END - $START" | bc)

	echo -e "$CYAN" "\n\n\t\tExecution time of the script : $DIFF seconds\n\n" "$NORMAL"

	exit
}


# ----------------------------------------------------------------------------------------------------- #

###################################################################################
# 
# Function rename() :
#
# 	- takes 5 arguments :
#		- $1 = ID
#		- $2 = Category
#		- $3 = Sub-category
#		- $4 = Path to folder containing 00_defi/, 01_blague/, 02_cuisine/ and 03_woz/
#		- $5 = extention of files to rename
#
#	- safely rename files
#
###################################################################################

rename(){
	if [ $# -ne 5 ]; then
		echo -e "$RED" "\nWrong number of arguments for function rename()\n\n" "$NORMAL"
		quit
	else
		id=$1
		cat=$2
		subcat=$3
		path=$4
		ext=$5
	fi

	for dir in "$path/"*; do
		f=`basename $dir`
		if [ "$f" == "00_defi" ]; then
			cd $dir
			i=0
			OLDIFS=$IFS
			IFS=$'\n'
			FIND=($(find . -type f -name "*$ext" -exec basename {} \;))
			IFS=$OLDIFS
			if [[ ${#FIND[@]} -ne 0 ]]; then
				echo -e "\nIn $YELLOW $dir :$NORMAL"
			fi
    		for (( i=0; i<${#FIND[@]}; i++ )); do
    			if [[ "${FIND[$i]}" != *"_00defi_"* ]]; then
    				if [ $subcat != "_" ]; then
						name=$id"_"$cat"_"$subcat"_00defi_"$i$ext
					else
						name=$id"_"$cat"_00defi_"$i$ext
					fi
					[ $DEBUG -eq 0 ] && mv -vi "${FIND[$i]}" "$name" || echo -e "${FIND[$i]} ~> $name"
					let i++
				else
					echo "File ${FIND[$i]} already renamed"
				fi
			done
		elif [ "$f" == "01_blague" ]; then
			cd $dir
			i=0
			OLDIFS=$IFS
			IFS=$'\n'
			FIND=($(find . -type f -name "*$ext" -exec basename {} \;))
			IFS=$OLDIFS
			if [[ ${#FIND[@]} -ne 0 ]]; then
				echo -e "\nIn $YELLOW $dir :$NORMAL"
			fi
    		for (( i=0; i<${#FIND[@]}; i++ )); do
    			if [[ "${FIND[$i]}" != *"_01blague_"* ]]; then
					if [ $subcat != "_" ]; then
						name=$id"_"$cat"_"$subcat"_01blague_"$i$ext
					else
						name=$id"_"$cat"_01blague_"$i$ext
					fi
					[ $DEBUG -eq 0 ] && mv -vi "${FIND[$i]}" "$name" || echo -e "${FIND[$i]} ~> $name"
					let i++
				else
					echo "File ${FIND[$i]} already renamed"
				fi
			done
		elif [ "$f" == "02_cuisine" ]; then
			if [ "$ext" != ".log" ]; then
				cd $dir
				i=0
				OLDIFS=$IFS
				IFS=$'\n'
				FIND=($(find . -type f -name "*$ext" -exec basename {} \;))
				IFS=$OLDIFS
				if [[ ${#FIND[@]} -ne 0 ]]; then
					echo -e "\nIn $YELLOW $dir :$NORMAL"
				fi
    			for (( i=0; i<${#FIND[@]}; i++ )); do
    				if [[ "${FIND[$i]}" != *"_02cuisine_"* ]]; then
						if [ $subcat != "_" ]; then
							name=$id"_"$cat"_"$subcat"_02cuisine_"$i$ext
						else
							name=$id"_"$cat"_02cuisine_"$i$ext
						fi
						[ $DEBUG -eq 0 ] && mv -vi "${FIND[$i]}" "$name" || echo -e "${FIND[$i]} ~> $name"
						let i++
					else
						echo "File ${FIND[$i]} already renamed"
					fi
				done
			else
				echo -e "\n$RED Ignoring files in $dir $NORMAL"
			fi
		elif [ "$f" == "03_woz" ]; then
			cd $dir
			i=0
			OLDIFS=$IFS
			IFS=$'\n'
			FIND=($(find . -type f -name "*$ext" -exec basename {} \;))
			IFS=$OLDIFS
			if [[ ${#FIND[@]} -ne 0 ]]; then
				echo -e "\nIn $YELLOW $dir :$NORMAL"
			fi
    		for (( i=0; i<${#FIND[@]}; i++ )); do
    			if [[ "${FIND[$i]}" != *"_03woz_"* ]]; then
					if [ $subcat != "_" ]; then
						name=$id"_"$cat"_"$subcat"_03woz_"$i$ext
					else
						name=$id"_"$cat"_03woz_"$i$ext
					fi
					[ $DEBUG -eq 0 ] && mv -vi "${FIND[$i]}" "$name" || echo -e "${FIND[$i]} ~> $name"
					let i++
				else
					echo "File ${FIND[$i]} already renamed"
				fi
			done
		else
			echo -e "$RED" "Error in function rename() : name $f is incorrect\n\n" "$NORMAL"
			quit
		fi
	done

	cd $workdir
}


# ----------------------------------------------------------------------------------------------------- #

###################################################################################
# 
# Checking arguments and current directory
#
###################################################################################

workdir=`pwd`

if [ $# -ne 1 ]; then
	usage
	echo -e "$RED" "\nWrong number of arguments\n\n" "$NORMAL"
	quit
elif [[ "$1" != "TEST" ]] && [[ "$1" != "RUN" ]]; then
	usage
	echo -e "$RED" "\nWrong option : $1\n\n" "$NORMAL"
	quit
elif [ ! -d "$workdir/Corpus/" ]; then
	usage
	echo -e "$RED" "\nNo Corpus/ directory found in $workdir : \n" "$YELLOW" "`ls -lh`\n\n" "$NORMAL"
	quit
fi

[[ "$1" == "TEST" ]] && DEBUG=1 || DEBUG=0

[ $DEBUG -eq 1 ] && test="$RED TEST" || test="$RED RUN"
echo -e "$CYAN\n\n\t\tStarting script in $test $CYAN mode...\n$NORMAL"


# ----------------------------------------------------------------------------------------------------- #

###################################################################################
# 
# Selecting extension(s) of files to rename
#
###################################################################################

echo -e "$GREEN" "\n[•] Selecting extensions" "$BLUE"
echo -e "$NORMAL"

options=(".wav files" ".mov files" ".log files")

menu() {
    echo -e "$YELLOW" "\nAvaliable options :" "$NORMAL"
    for i in ${!options[@]}; do 
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
    done
    [[ "$msg" ]] && echo -e "\n$BLUE$msg$NORMAL\n"; :
}

echo -e "$BLUE"

prompt="Check files you want to rename (again to uncheck, ENTER when done): "
while menu && read -rp "$prompt" num && [[ "$num" ]]; do
    [[ "$num" != *[![:digit:]]* ]] &&
    (( num > 0 && num <= ${#options[@]} )) ||
    { msg="Invalid option: $num"; continue; }
    ((num--)); msg="${options[num]} was ${choices[num]:+un}checked"
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="++"
done

printf "$CYAN\n\n\tYou selected"; msg=" nothing"
for i in ${!options[@]}; do 
    if [[ "${choices[i]}" ]]; then
    	printf " %s" "${options[i]}"; msg="";
    	# echo "${options[i]}"
		if [[ "$i" == "0" ]]; then
			ext_audio=".wav"
		elif [[ "$i" == "1" ]]; then
			ext_video=".mov"
		elif [[ "$i" == "2" ]]; then
			ext_log=".log"
		fi
    fi
done
echo -e "$RED$msg\n\n"

workdir="$workdir/Corpus"
path_data="$workdir/Data"


# ----------------------------------------------------------------------------------------------------- #

###################################################################################
# 
# Checkink consistency of folders structure
#
###################################################################################

echo -e "$GREEN" "\n[•] Checking structure of folders in" "$RED" "$workdir/" "$NORMAL\n"

for dir in "$workdir/"*; do
	f=`basename $dir`
	if [ "$f" == "DB_subjects" ]; then
		echo -e "$YELLOW" "Found Corpus/$f" "$NORMAL"
	elif [ "$f" == "Data" ]; then
		echo -e "$YELLOW" "Found Corpus/$f" "$NORMAL"
		n=( $(find $dir -type d -maxdepth 1 | wc -l) )
		let n--
		echo -e "$GREEN" "\tFound $n subjects\n" "$NORMAL"
		find $path_data -depth -empty -exec echo -e "\t$RED"{}"$NORMAL is empty" \;
	elif [ "$f" == "Photo" ]; then
		echo -e "$YELLOW" "Found Corpus/$f" "$NORMAL"
	else
		echo -e "$RED" "Error checking structure of folders\n\n" "$NORMAL"
		quit
	fi

	if [ -z "`find $dir -type f`" ]; then
		echo -e "$RED$dir$NORMAL is empty\n"
	fi
done


# ----------------------------------------------------------------------------------------------------- #

###################################################################################
# 
# Checkink consistency of files
#
###################################################################################

echo -e "$GREEN" "\n[•] Checking files in" "$RED" "$path_data/" "$NORMAL\n"

no_ext=($(find $path_data -type f ! -name "*.*" | wc -l)) 
[ $no_ext -gt 1 ] && v="files" || v="file"
echo -e "$CYAN Found $no_ext $v with no extension $NORMAL"

echo -e "$RED"
for subject in "$path_data/"*; do
	for category in "$subject/"*; do
		cat=`basename $category`
		if [ "$cat" == "Audio" ]; then
			find $category -type f ! -name "*.wav" -exec echo -e "$NORMAL File is not a valid audio file : $RED" {} \;
		elif [ "$cat" == "Video" ]; then
			find $category -type f ! -name "*.mov" -exec echo -e "$NORMAL File is not a valid video file : $RED" {} \;
		elif [ "$cat" == "Log" ]; then
			find $category -type f ! -name "*.log" -exec echo -e "$NORMAL File is not a valid log file : $RED" {} \;
		fi
	done
done

echo -e "$NORMAL"


# ----------------------------------------------------------------------------------------------------- #

###################################################################################
# 
# Renaming files
#
###################################################################################

echo -e "$GREEN" "\n\n[•] Renaming files in" "$RED" "$path_data/" "$BLUE"
read -p "Press enter to continue or Ctrl+C to stop"
echo -e "$NORMAL"

if [ ! "$ext_audio" ] && [ ! "$ext_video" ] && [ ! "$ext_log" ]; then
	echo -e "$RED" "\nNo extension(s) selected -> exiting.\n" "$NORMAL"
	quit
fi

for subject in "$path_data/"*; do
	id=`basename $subject`
	for category in "$subject/"*; do
		cat=`basename $category`
		subcat="_"
		if [ "$cat" == "Audio" ]; then
			[ "$ext_audio" ] && rename $id $cat $subcat $category $ext_audio
		elif [ "$cat" == "Video" ]; then
			[ "$ext_video" ] && for subcategory in "$category/"*; do
				subcat=`basename $subcategory`
				rename $id $cat $subcat $subcategory $ext_video
			done
		elif [ "$cat" == "Log" ]; then
			[ "$ext_log" ] && rename $id $cat $subcat $category $ext_log
		else
			echo -e "$RED" "Error renaming files in " "$RED" "$category/\n\n" "$NORMAL"
		fi
	done
done


# ----------------------------------------------------------------------------------------------------- #

###################################################################################
# 
# Everything went well, safely exit
#
###################################################################################

quit


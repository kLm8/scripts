#!/bin/bash

NORMAL="\\033[0;39m"
RED="\\033[1;31m"
GREEN="\\033[1;32m"
YELLOW="\\033[1;33m"
BLUE="\\033[1;34m"
CYAN="\\033[1;36m"

clear


# ----------------------------------------------------------------------------------------------------- #

usage(){
	echo -e "$CYAN" "\n\n ######################################################################"
	echo -e "$CYAN" "#"
	echo -e "$CYAN" "# \t\t\tStructure :"
	echo -e "$CYAN" "#"
	echo -e "$CYAN" "# -Corpus"
	echo -e "$CYAN" "# \t-Data"
	echo -e "$CYAN" "# \t\t-ID"
	echo -e "$CYAN" "# \t\t\t-Audio"
	echo -e "$CYAN" "# \t\t\t\t-00_defi"
	echo -e "$CYAN" "# \t\t\t\t-01_blague"
	echo -e "$CYAN" "# \t\t\t\t-02_cuisine"
	echo -e "$CYAN" "# \t\t\t\t-03_woz"
	echo -e "$CYAN" "# \t\t\t-Video"
	echo -e "$CYAN" "# \t\t\t\t-front"
	echo -e "$CYAN" "# \t\t\t\t\t-00_defi"
	echo -e "$CYAN" "# \t\t\t\t\t-01_blague"
	echo -e "$CYAN" "# \t\t\t\t\t-02_cuisine"
	echo -e "$CYAN" "# \t\t\t\t\t-03_woz"
	echo -e "$CYAN" "# \t\t\t\t-back"
	echo -e "$CYAN" "# \t\t\t\t\t-00_defi"
	echo -e "$CYAN" "# \t\t\t\t\t-01_blague"
	echo -e "$CYAN" "# \t\t\t\t\t-02_cuisine"
	echo -e "$CYAN" "# \t\t\t\t\t-03_woz"
	echo -e "$CYAN" "# \t\t\t\t-side"
	echo -e "$CYAN" "# \t\t\t\t\t-00_defi"
	echo -e "$CYAN" "# \t\t\t\t\t-01_blague"
	echo -e "$CYAN" "# \t\t\t\t\t-02_cuisine"
	echo -e "$CYAN" "# \t\t\t\t\t-03_woz"
	echo -e "$CYAN" "# \t\t\t-Log"
	echo -e "$CYAN" "# \t\t\t\t-00_defi"
	echo -e "$CYAN" "# \t\t\t\t-01_blague"
	echo -e "$CYAN" "# \t\t\t\t-02_cuisine"
	echo -e "$CYAN" "# \t\t\t\t-03_woz"
	echo -e "$CYAN" "# \t-Photo"
	echo -e "$CYAN" "# \t-DB_subjects"
	echo -e "$CYAN" "# \t\t-Questionnaires"
	echo -e "$CYAN" "# \t\t-Information"
	echo -e "$CYAN" "# \t\t-Mapping"
	echo -e "$CYAN" "#"
	echo -e "$CYAN" "#"
	echo -e "$CYAN" "######################################################################\n"
}


# ----------------------------------------------------------------------------------------------------- #

make4dirs(){
	echo -e "$YELLOW" "$1" "$NORMAL"
	mkdir -p "$1/00_defi" "$1/01_blague" "$1/02_cuisine" "$1/03_woz"
	touch "$1/00_defi/aa" "$1/01_blague/bb" "$1/02_cuisine/cc" "$1/03_woz/dd"
}

# ----------------------------------------------------------------------------------------------------- #


if [ $# -ne 0 ]; then
	usage
	echo -e "$RED" "\nWrong number of arguments\n\n" "$NORMAL"
	exit
fi


# ----------------------------------------------------------------------------------------------------- #

usage

echo -e "$CYAN" "\n\n\t\tStarting script...\n" "$NORMAL"
START=$(date +%s.%N)


# ----------------------------------------------------------------------------------------------------- #

echo -e "$GREEN" "\n[•] Creating structure of folders in" "$RED" `pwd` "$GREEN" "for" "$RED" "37" "$GREEN" "participants" "$BLUE"
read -p "Press enter to continue or Ctrl+C to stop"
echo -e "$NORMAL"

path="Corpus/Data"

for (( i=0; i<=36; i+=1 ))
do
	if [ $i -le 9 ]; then
		make4dirs "$path/0$i/Audio"
		make4dirs "$path/0$i/Video/front"
		make4dirs "$path/0$i/Video/back"
		make4dirs "$path/0$i/Video/side"
		make4dirs "$path/0$i/Log"
	else
		make4dirs "$path/$i/Audio"
		make4dirs "$path/$i/Video/front"
		make4dirs "$path/$i/Video/back"
		make4dirs "$path/$i/Video/side"
		make4dirs "$path/$i/Log"
	fi
done

mkdir -p "Corpus/Photo"
mkdir -p "Corpus/DB_subjects/Questionnaires"
mkdir -p "Corpus/DB_subjects/Information"
mkdir -p "Corpus/DB_subjects/Mapping"


# ----------------------------------------------------------------------------------------------------- #

echo -e "$GREEN" "\n[•] Done !"
echo -e "$NORMAL"
# ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
ls -F Corpus/*


# ----------------------------------------------------------------------------------------------------- #

END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo -e "$CYAN" "\n\n\t\tExecution time of the script : $DIFF seconds\n" "$NORMAL"

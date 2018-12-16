#!/bin/bash
####Umgebungsvariabeln####
standardlogs=
readonly VERSION=0.0.1
readonly SCRIPT_NAME=${0##*/}
readonly TEMP=
##########################
##GitTest###
function help_command() {
cat <<END;
#################################################################################
#	USAGE:									#
#		$SCRIPT_NAME command [options]					#
#										#
#	Options:								#
#		-h		Alias für help					#
#		-v		Alias für version				#
#		-l		Alias für list 					#
#										#
#	Commands:								#
#		help		Anzeigen der Hilfe				#
#		version		Anzeigen der Scriptversion			#
#		list		Anzeigen aller Dateien im Log Ordner		#
#		call		Script 'call.sh' aufrufen			#
#		paste		Script 'paste.sh' aufrufen			#
#		show		tmp Datei anzeigen				#
#		clean		tmp Datei löschen				#
#################################################################################
END
}

function version_info (){
	echo "$SCRIPT_NAME hat die Version: $VERSION"
}

function list_files(){
	filelist=$(cd $standardlogs; ls)
	for file in $filelist; do
		echo $file
	done
}


function main (){
    case $1 in
        -h | --help | help )    help_command
                                exit
                                ;;
		-c | --call | call )
								shift 1
								. ./command/call.sh
								;;
		-v | --version | version )
								version_info
								exit
								;;
		-s | --show | show )
								shift 1
								. ./command/view.sh
								;;
		-l | --list | list )	list_files
								exit
								;;
		-p | --paste | paste )
								shift 1
								. ./command/paste.sh
								;;
		clean )
								shift 1
								. ./command/clean.sh
								;;
		-d | --diff | diff )
								shift 1
								. ./command/diff.sh
								;;
        * )                     echo "$1 nicht bekannt"
								help_command
                                exit 1
								;;
    esac




}
if [[ $1 = "" ]]; then
	help_command ;
else
	main "$@"
fi
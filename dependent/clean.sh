#!/bin/bash
force=n
function help_command() {
cat <<END;
#################################################################################
#	USAGE:									#
#		$SCRIPT_NAME clean [options]					#
#										#
#	Funktion:								# 
#		Tmp Datei löschen 						#
#										#
#	Options:								#
#		-h		Hilfe anzeigen					#
#		-f		force (optional)				#
#################################################################################
END
}
function clean_log(){
	if [ -f $TEMP ]; then
		echo "Wollen sie $TEMP wirklich löschen(y/n)?"
		read choice
		if [[ $choice = y ]]; then
			rm $TEMP
			echo "Datei erfolgreich gelöscht!"
		else
			echo "Datei $TEMP nicht gelöscht."
		fi
	else
		echo "Datei $TEMP nicht vorhanden"
		exit 1;
	fi
	
}

function clean_log_force(){
	if [ -f $TEMP ]; then
		rm $TEMP
		echo "$TEMP erfolgreich gelöscht"
	else
		echo "Datei $TEMP nicht vorhanden"
		exit 1;
	fi
	
}

function main (){
while getopts "f" opt 2>/dev/null
   do
     case $opt in
		f ) force=y
            ;;
		h )	help_command
			exit;;
		? ) echo "($0): Ein Fehler bei der Optionsangabe"
			help_command
			exit 1;;
     esac
done

if [[ $force = y ]]; then
	clean_log_force
else
	clean_log
fi

}
	main "$@"

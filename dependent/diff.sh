#!/bin/bash
force=n
function help_command() {
cat <<END;
#################################################################################
#	USAGE:									#
#		$SCRIPT_NAME clean [options]					#
#										#
#	Funktion:								# 
#		2 Dateien im log-Ordner vergleichen 				#
#										#
#	Options:								#
#		-h		Hilfe anzeigen					#
#		-f		2 Dateien spezifizieren (zwingend)		#
#################################################################################
END
}


function diff_log(){
	tempdatei1=$standardlogs/${file[1]}
	tempdatei2=$standardlogs/${file[2]}
		echo $tempdatei2
	if [ -f $tempdatei1 ]; then
		var1=1
	else
		echo "Datei $tempdatei1 nicht vorhanden!"
	fi
	if [ -f $tempdatei2 ]; then
		var1=1
	else
		echo "Datei $tempdatei1 nicht vorhanden."
	fi
	
	if [ -f $tempdatei1 ] && [ -f $tempdatei2 ]; then
		diff -s $tempdatei1 $tempdatei2
	fi
}

function main (){
while getopts "fh" opt 2>/dev/null
   do
     case $opt in
		f ) file=("$OPTARG")
            until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
                file+=($(eval "echo \${$OPTIND}"))
                OPTIND=$((OPTIND + 1))
            done
            ;;
		h )	help_command
			exit;;
		? ) echo "($0): Ein Fehler bei der Optionsangabe"
			help_command
			exit 1;;
     esac
done

diff_log
}
if [[ $1 = "" ]]; then
	help_command ;
else
	main "$@"
fi

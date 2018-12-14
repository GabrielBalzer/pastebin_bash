#!/bin/bash
function help_command() {
cat <<END;
#################################################################################
#	USAGE:									#
#		$SCRIPT_NAME paste [options]					#
#										#
#	Funktion:								# 
#		Spezifizierte Dateien an tmp Datei anhängen 			#
#										#
#	Options:								#
#		-h		Hilfe anzeigen					#
#		-f		Dateien zum pasten spezifizieren (zwingend)	#
#################################################################################
END
}
function paste_log(){
	for datei in ${file[@]}; do
	tempdatei=$standardlogs/$datei
	if [ -f $tempdatei ]; then
		cat $tempdatei >> $TEMP
	else
		echo "Datei $tempdatei nicht vorhanden"
	fi
	done
}

function main (){
while getopts "hf:s" opt 2>/dev/null
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
if [[ ${file[0]} = "" ]]; then
	var1=1
else
	paste_log
fi
echo ${file[@]}
}
if [[ $1 = "" ]]; then
	help_command ;
else
	main "$@"
fi
#!/bin/bash
function help_command() {
cat <<END;
#################################################################################
#	USAGE:									#
#		$SCRIPT_NAME call [options]					#
#										#
#	Options:								#
#		-h		Hilfe anzeigen					#
#		-s		lala ausgeben					#
#		-f		Dateien spezifizieren 				#
#################################################################################
END
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
		s ) echo "lala";;
		h )	help_command
			exit;;
		? ) echo "($0): Ein Fehler bei der Optionsangabe"
			help_command
			exit 1;;
     esac
done
echo ${file[@]}
}
if [[ $1 = "" ]]; then
	help_command ;
else
	main "$@"
fi
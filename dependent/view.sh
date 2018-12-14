#!/bin/bash
function help_command() {
cat <<END;
#################################################################################
#	USAGE:									#
#		$SCRIPT_NAME view [options]					#
#										#
#	Funktion:								# 
#		Tmp Datei auslesen 			#
#										#
#	Options:								#
#		-h		Hilfe anzeigen					#
#		-f		Dateien zum pasten spezifizieren (zwingend)	#
#################################################################################
END
}

function tmp_view(){
	if [ -f $TEMP ]; then
		cat $TEMP
	else
		echo "Datei nicht vorhanden"
	fi
}

function main (){
	tmp_view
}
	main "$@"

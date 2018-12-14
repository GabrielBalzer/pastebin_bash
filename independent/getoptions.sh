#!/bin/bash
####Umgebungsvariabeln####
standardlogs=/var/iamshare/LEARNING/_ROOT/gb/log
readonly VERSION=0.0.1
readonly SCRIPT_NAME=${0##*/}
readonly TEMP=/tmp/paste.log
##########################
function help_command() {
cat <<END;
#################################################################################
#	USAGE:									#
#		$SCRIPT_NAME [options] command					#
#										#
#	Options:								#
#		-h		Alias für help					#
#		-v		Alias für version				#
#		-l		Alias für list 					#
#		-f		Datei/Dateien zum anschauen definieren		#
#		-g		Datei-Filter setzen				#
#										#
#	Commands:								#
#		help		Anzeigen der Hilfe				#
#		version		Anzeigen der Scriptversion			#
#		list		Anzeigen aller Dateien im Log Ordner		#
#		paste		Eine mit -f spezifizierte Datei in 		#
#				tmp Ordner schreiben				#
#		view		Anzeigen der TMP Datei				#
#		clean		Temp File löschen				#
#		diff		Eine mit -f spezifizierte Datei			#
#				mit TMP Datei vergleichen			#
#################################################################################
END
}
function show_log (){
	for dateien in ${file[@]}; do
		tempdatei=$standardlogs/$dateien
		if [ -f $tempdatei ]; then
			echo "Datei: $dateien vorhanden"
		else
			echo "Datei: $dateien nicht vorhanden"
			exit 1
		fi
		
		if [ -n "$grep" ]; then
			echo "Grep Variable vorhanden"
			more $tempdatei | grep -i $grep
		else
			echo "Grep Variable nicht vorhanden"
			more $tempdatei
		fi
		echo "--------------------------------------------------------------------------------------------------"
	done
	
}

function paste_log(){
	tempdatei=$standardlogs/${file[0]}
	if [ -f $tempdatei ]; then
		var=1
	else
		echo "Datei $tempdatei nicht vorhanden"
		exit 1;
	fi
	if [ -f $TEMP ]; then
		echo "An bestehende Datei wird angehängt"
	else
		echo "Neue Datei wird erzeugt"
	fi
	cat $tempdatei >> $TEMP

	
}

function tmp_view(){
	if [ -f $TEMP ]; then
		cat $TEMP
	else
		echo "Datei nicht vorhanden"
	fi
}

function clean_log(){
	if [ -f $TEMP ]; then
		rm $TEMP
		echo "$TEMP erfolgreich gelöscht"
	else
		echo "Datei $TEMP nicht vorhanden"
		exit 1;
	fi
	
}

function diff_log(){
	tempdatei=$standardlogs/${file[0]}
	if [ -f $TEMP ]; then
		echo "$TEMP vorhanden"
		diff -s $TEMP $tempdatei
	else
		echo "Datei $TEMP nicht vorhanden"
		exit 1;
	fi
}

function version_info (){
	echo "$SCRIPT_NAME hat die Version: $VERSION"
}

function list_files(){
	filelist=$(cd $standardlogs; ls -1b)
	echo -e "Dateiliste:\n $filelist"
}

function main (){ 

while getopts "hvlg:f:" opt 2>/dev/null
   do
     case $opt in
        g ) grep=$OPTARG;;
        f ) file+=("$OPTARG");;
		h)
			help_command;;
		v)
			version_info;;
		l)
			list_files;;
		?)
			echo "($0): Ein Fehler bei der Optionsangabe"
			help_command;;
     esac
done

shift $((OPTIND-1))
command="$1" && shift
args="$@"
case "$command" in
    help)     
		help_command ;;
    version)  
		version_info ;;
	paste)
		TODO=paste;;
	clean)
		clean_log ;;
	diff)
		TODO=diff ;;
	view)
		tmp_view ;;
	list)
		list_files ;;
	show)
		TODO=show;;
    *)  
		if [[ $command = "" ]]; then
			exit 1;
		fi
		echo "Unknown '$command'"
		echo "Type ./$SCRIPT_NAME help for Help"
		exit 1;
		;;
esac
if [[ ! ${file[0]} = "" ]] && [[ $TODO = "show" ]]; then
	count=1
	for datei in ${file[@]}; do
		echo "Datei #$count: $datei"
		let count=count+1
	done
	show_log
else
	var=1
fi

if [[ ! ${file[0]} = "" ]] && [[ $TODO = "paste" ]]; then
	paste_log
else
	var=1
fi

if [[ ! ${file[0]} = "" ]] && [[ $TODO = "diff" ]]; then
	diff_log
else
	var=1
fi

}

main "$@"


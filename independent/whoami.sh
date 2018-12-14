#!/bin/bash
### BEGIN INIT INFO
# Provides:          gabriel
# Required-Start:    $syslog $network
# X-UnitedLinux-Should-Start: $syslog $network
# Required-Stop:     $syslog
# X-UnitedLinux-Should-Stop: $syslog
# Default-Start:     3
# Default-Stop:      0 1 2 6
# Short-Description: sendet Konfigurationsdaten
# Description:       Demoscript von Gabriel Balzer
### END INIT INFO

readonly VERSION=0.0.1

LOGFILE="/tmp/gabriel.log"

function help_command() {
cat <<END;
	USAGE:
		./start_stop.sh <command>
		
	Options:
		-h, -help		Alias für help
		-v			Alias für version
		-c			Alias für cleanup
		
		
	COMMANDS:
		start			Erzeugung einer Prozessliste
		stop			Erzeugung einer Prozessliste
		view			Prozessliste anzeigen
		cleanup			Löschen der Prozessliste
		version			Version des Scripts anzeigen
		help			Hilfe anzeigen
		
END
}

create_process() {
		user=$(who)
		id=$(id -a)
		printf "#### %s - %s\n"  "$(date +'%Y-%m-%d %H:%M:%S')" "$1" >> $LOGFILE
		printf "Script ausgeführt um: %s\nUser-ID: %s\nHostname: %s\n" "$(date)" "$id" "$(hostname)" >> $LOGFILE
		echo "Angemeldete Nutzer zur Zeit der Scriptausführung: $user" >> $LOGFILE
		ps -ef >> $LOGFILE
}

getops() {
	for i in $@; do 
		if [ -f $i ]; then
			# wenn Datei, dann ...
			echo "Is a File $i"
		fi
		# Optionen auswerten
	done
}

getops 

case "$1" in
	start)  
		create_process $@
		echo "Prozessliste erzeugt"
		;;
	stop)
		create_process $@
		echo "Prozessliste erzeugt"
			;;
	help|-h|-help)
			help_command;;
	view)
			if [ -f $LOGFILE ];
			then
				cat $LOGFILE
			else
				echo "Keine Prozessliste vorhanden"
			fi
			;;
	cleanup|-c)
		if [ -f $LOGFILE ];
		then
			rm $LOGFILE
			echo "Prozessliste gelöscht"
		else
			echo "Keine Prozessliste vorhanden"
		fi
		
		;;
	version|-v)
			echo "Aktuelle Script Version: $VERSION ."
			;;
	   *)
	   		echo "Eingabefehler: $@."; echo
		 	help_command
			;;
esac


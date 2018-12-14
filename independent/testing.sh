#!/bin/bash
clear
function what_todo()
{
	echo "Was möchten sie tun? (a-Shell-Version anzeigen,b-Apache-Version anzeigen ,c-Log-Speicherorte,x-Shell-Script-beenden)"
}

function command_-i()
{
	echo "Interaktiver Modus ausgewählt"
	what_todo
	while :
	do
	read userinput
	case $userinput in
		a)
			clear
			user=$(whoami)
			shell=$SHELL
			version=$BASH_VERSION
			echo "Hallo $user, Sie verwenden die $shell Shell in der Version: $version"
			what_todo
			;;
		b)
			clear
			apacheversion=$(apachectl -v)
			echo $apacheversion
			what_todo
			;;
		c)
			clear
			list="10_profile_httpd.conf 15_gb_apache.conf 10_httpd-interflex.conf"
			for i in $list
			do
				confdestination=$(locate -i $i)
				servername=$(cat $confdestination | grep ServerName)
				accesslogdestination=$(cat $confdestination | grep CustomLog)
				accessformat=${$accesslogdestination//CustomLog/1}
				echo $accessformat
				errorlogdestination=$(cat $confdestination | grep ErrorLog)
				printf "Server: %s\nConf-File: %s\n" "$servername" "$i"
				echo $accesslogdestination
				echo $errorlogdestination
				echo "-----------------------------------------------------------------------------"
			done		
			what_todo
			;;		
		x)
			clear
			echo "Shell-Script erfolgreich beendet"
			break
			;;
	esac
	done
}
if [ -n "$1" ]; then
	command_$1
else
	echo "Standard Modus ausgewählt (-i für Interaktivmodus)"
fi



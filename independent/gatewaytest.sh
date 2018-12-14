#!/bin/bash
#Apache Version anzeigen

i=1
for datei in $@; do
	echo "Server $i: $datei"
	let "i+=1"
	#ssh -qx $datei '/usr/sbin/apachectl -v'
done




#ssh -qx server 'uname -a; hostname -I; uptime; /usr/sbin/apachectl -v'
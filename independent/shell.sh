#!/bin/bash

world="Hello World"

echo $world

if [ 35 -gt 12 ]
then
 echo "Greater"
else
 echo "Lesser"
fi



for i in 1 2 3 4 5
do
echo "Hello World $i"
done

i=6
while [ $i -le 10 ]
do
	echo "Hello World $i"
	i=`expr $i + 1`
done


print_date()
{
echo "Today is `date +"%A %d %B %Y (%r)"`"
return
}


now=$(date +%s)

echo "Geburtsdatum im Format Jahr-Monat-Tag eingeben"
read timedate

past=$(date +%s --date $timedate)



difference=$(($now-$past))


days=$(($difference/(3600*24)))
echo Du bist $days Tage alt.



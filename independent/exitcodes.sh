#!/bin/bash
touch /root/test 2> /dev/null

if [ $? -eq 0 ]
then
  echo "Successfully created file"
else
  echo "Could not create file" >&2
fi


scratch=$(mktemp -d -t tmp.XXXXXXXXXX)
function finish {
  rm -rf "$scratch"
  echo "Haha"
}
trap finish EXIT

while :			# This is the same as "while true".
do
        sleep 60	# This script is not really doing anything.
done
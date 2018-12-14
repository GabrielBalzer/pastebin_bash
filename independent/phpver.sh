#!/bin/bash

_PHPINST=$(which php)

if [ -n "_PHPINST" ]; then
    echo; echo "  Location: $_PHPINST"; echo
    echo; php -v; echo
else
    echo; echo "  PHP is not installed or not in \$PATH."; echo
    exit 9
fi

echo "Completed!"; echo
exit 0

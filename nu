#!/bin/bash

;PATH+=/sbin
adapter=eth0
internal=""

internal=$(
    /sbin/ifconfig "$adapter" |
        awk -F'(inet add?r:| +|:)' '/inet add?r/{print $3}'
        )

if [[ !  $internal =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]]; then
    sudo service networking start
fi

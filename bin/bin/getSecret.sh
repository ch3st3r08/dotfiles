#!/usr/bin/env bash

# Convert newlines to commas, so just one line
#lssecret -s | tr '\n' ','
#
# Convert double ",," to newlines ",," means empty line
#sed -e "s/,,/\\n/g"
#
# Search for the word, using parameter $1
#grep "Item:[[:space:]]$1"
#
# Get the line and get Secret
#awk -F ','  '{ print $2 }' | tr -d 'Secret:[:blank:]'
#
result=$(lssecret -s | tr '\n' ',' | sed -e "s/,,/\\n/g" | grep "Item:[[:space:]]$1" | awk -F ',' '{ print $2 }' | awk -F ' ' '{ print $2 }' )
echo $result

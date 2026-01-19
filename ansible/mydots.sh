#!/bin/bash

while getopts "e:t:vh" opt; do
  case $opt in
    e)
      DE="$OPTARG"  # Option argument is in $OPTARG
      ;;
    n)
      TAG="$OPTARG"
      ;;
    v)
      VERBOSE=true
      ;;
    h)
      echo "Usage: mydots.sh [-e de_name] [-t tags] [-v] passwd"
      exit 0
      ;;
    :)
      echo "Error: -$OPTARG requires an argument"
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
  esac
done

shift $((OPTIND-1))

if [[ -n $TAG ]]; then
  $TAG_LINE="--tags $TAG"
fi
if [[ -n $DE ]]; then
  $DE_LINE="de=$DE"
fi

ansible-playbook main.yml --check --ask-become-pass $TAG_LINE -e "do_pass=$1" $DE_LINE

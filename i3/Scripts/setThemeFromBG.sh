#!/bin/bash

bg=$(cat ~/.config/nitrogen/bg-saved.cfg | grep file | cut -d "=" -f 2)
(wpg -A $bg && wpg -s $bg) > /dev/null 2>&1


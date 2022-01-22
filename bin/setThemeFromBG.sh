#!/bin/bash

bg=$(cat ~/.config/nitrogen/bg-saved.cfg | grep file | cut -d "=" -f 2)
wal -i $bg -n

#!/bin/zsh

$KIALO_ROOT/development/aws/rotate_access_key.py
cat $KIALO_ROOT/.aws/credentials | gopass insert -f aws/credentials
gopass sync --store root

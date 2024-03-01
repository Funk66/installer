#!/bin/zsh

if [ -z "$1" ] || [ -n "$2" ]; then
  . $KIALO_ROOT/development/aws/assume_role.sh $@
else
  . $KIALO_ROOT/development/aws/assume_role.sh $@ admin
fi
unset KUBECONFIG

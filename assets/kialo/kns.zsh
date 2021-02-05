#!/usr/bin/zsh

CONTEXT="$(kubectl config current-context)"
NAMESPACE="$(kubectl config view -o jsonpath="{.contexts[0].context.namespace}")"
[ "$NAMESPACE" = "$1" ] && return
SELECTION=$(kubectl get namespaces -o name | cut -d '/' -f 2 | fzf -1 --height 5 --reverse --query="${1:-""}")
[ -z "$SELECTION" ] || [ "$SELECTION" = "$NAMESPACE" ] && return
kubectl config set-context "$CONTEXT" --namespace="$SELECTION" > /dev/null
echo -e "Switched to \033[92m$SELECTION\033[0m"

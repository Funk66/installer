#!/bin/zsh

[ -z "$KUBECONFIG" ] && echo "No context" && return 1
CONTEXT=$(echo "$KUBECONFIG" | cut -d '/' -f 8 | sed -E 's/-[a-z]+$//')
CACHE="${KIALO_ROOT}/.kube/${CONTEXT}-ns"
NAMESPACE="$(kubectl config view -o jsonpath="{.contexts[0].context.namespace}")"
[ "$NAMESPACE" = "$1" ] && return
[ -n "$2" ] || ([ -f "$CACHE" ] && ([ "$(find $CACHE -mtime +3)" ])) && rm "$CACHE"
NAMESPACES=$(cat $CACHE 2> /dev/null || echo "")
MATCH=$(echo "$NAMESPACES" | fzf --filter="$1")
if [ -z "$MATCH" ]; then
  NAMESPACES=$(kubectl get namespaces -o name | cut -d '/' -f 2 | tee $CACHE)
  MATCH=$(echo "$NAMESPACES" | fzf --filter="$1")
  [ -z "$MATCH" ] && echo "Namespace not found" && return 1
fi
SELECTION=$(echo "$NAMESPACES" | fzf -1 --height 5 --reverse --query="${1:-""}")
[ -z "$SELECTION" ] || [ "$SELECTION" = "$NAMESPACE" ] && return
kubectl config set-context "$CONTEXT" --namespace="$SELECTION" > /dev/null
echo -e "Switched to \033[92m$SELECTION\033[0m"

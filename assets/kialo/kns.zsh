#!/usr/bin/zsh

[ -z "$KUBECONFIG" ] && echo "No context" && return 1
CONTEXT=$(echo "$KUBECONFIG" | cut -d '/' -f 8)
CACHE="${KIALO_ROOT}/.kube/${CONTEXT}-ns"
NAMESPACE="$(kubectl config view -o jsonpath="{.contexts[0].context.namespace}")"
[ "$NAMESPACE" = "$1" ] && return
[ -f "$CACHE" ] && ([ "$(find $CACHE -mtime +3)" ] && rm "$CACHE")
NAMESPACES=$(cat $CACHE 2> /dev/null || kubectl get namespaces -o name | cut -d '/' -f 2 | tee $CACHE)
SELECTION=$(echo "$NAMESPACES" | fzf -1 --height 5 --reverse --query="${1:-""}")
[ -z "$SELECTION" ] || [ "$SELECTION" = "$NAMESPACE" ] && return
kubectl config set-context "$CONTEXT" --namespace="$SELECTION" > /dev/null
echo -e "Switched to \033[92m$SELECTION\033[0m"

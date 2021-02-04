#!/usb/bin/zsh

typeset -A CLUSTERS=(
  development "development    us-east-1    namespace"
  testing     "testing        us-east-1    namespace"
  production  "production     us-east-1    namespace"
)

CLUSTER=$1
[ -z $CLUSTERS[$CLUSTER] ] && CLUSTER=$(echo ${(k)CLUSTERS} | tr ' ' '\n' | fzf -1 --height 9 --reverse --query=${CLUSTER})
[ -z $CLUSTER ] || [[ "${KUBECONFIG}" =~ "/${CLUSTER}$" ]] && return
read ACCOUNT REGION NAMESPACE <<< $(echo $CLUSTERS[$CLUSTER])
[ "$AWSUME_PROFILE" != "$ACCOUNT" ] && assume $ACCOUNT
export KUBECONFIG=$KIALO_ROOT/.kube/$CLUSTER

if [ ! -f $KUBECONFIG ] || [ "$(find $KUBECONFIG -mmin +59)" ]
then
  aws eks update-kubeconfig --name "$CLUSTER" --alias "$CLUSTER" --region "$REGION"
  kubectl config set-context "$CLUSTER" --namespace "$NAMESPACE"
fi

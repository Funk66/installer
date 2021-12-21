#!/usr/bin/zsh

typeset -A ACCOUNTS=(
  development 1234567890
  testing     1234567890
  production  1234567890
)

ACCOUNT=$1
[ -z ${ACCOUNTS[$ACCOUNT]} ] && ACCOUNT=$(echo ${(k)ACCOUNTS} | tr ' ' '\n' | fzf -1 --height 10 --reverse --query=$ACCOUNT)
[ -z $ACCOUNT ] || [ "$ACCOUNT" = "$AWS_PROFILE" ] && return
FILE=$KIALO_ROOT/.aws/$ACCOUNT

if [ ! -f "$FILE" ] || [ "$(find $FILE -mmin +720)" ]
then
  unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_PROFILE
  MFA_CODE=$(ykman oath accounts code aws | awk '{print $2}')
  [ -z ${MFA_CODE} ] && return 1
  ROLE_INFO=($(aws sts assume-role --duration-seconds 43200 --role-arn "arn:aws:iam::${ACCOUNTS[$ACCOUNT]}:role/admin" --role-session-name "cli" --serial-number "$MFA_SERIAL" --token-code "$MFA_CODE" --no-cli-auto-prompt | jq -r ".Credentials[]"))
  [ "${#ROLE_INFO}" -ne 4 ] && return
  cat << EOF >! $FILE
export AWS_ACCESS_KEY_ID=${ROLE_INFO[1]}
export AWS_SECRET_ACCESS_KEY=${ROLE_INFO[2]}
export AWS_SESSION_TOKEN=${ROLE_INFO[3]}
export AWS_PROFILE=${ACCOUNT}
EOF
fi

unset KUBECONFIG
. $FILE

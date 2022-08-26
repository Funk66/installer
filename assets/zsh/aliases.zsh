if [ ! $(uname) = "Darwin" ]
then
  alias ip='ip -color=auto'
  alias ls='ls --color=auto'
  alias diff='diff --color=auto'
fi
alias grep='grep --color=auto'
alias d='dirs -v'

alias isodate='date -u +"%Y-%m-%dT%H:%M:%SZ"'
alias moon='curl wttr.in/Moon'
alias weather='curl wttr.in/Berlin'

alias otp="ykman --device 6931997 oath accounts code aws --single | pbcopy"

cht() {
  curl cht.sh/$1
}

grim() {
    vim $(rg -l "$1")
}

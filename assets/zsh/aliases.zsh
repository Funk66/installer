if [ ! $(uname) = "Darwin" ]
then
  alias ip='ip -color=auto'
  alias ls='ls --color=auto'
  alias diff='diff --color=auto'
fi
alias python=python3
alias grep='grep --color=auto'
alias d='dirs -v'

alias isodate='date -u +"%Y-%m-%dT%H:%M:%SZ"'

cht() {
  curl cht.sh/$1
}

grim() {
    vim $(rg -l "$1")
}

if [ ! $(uname) = "Darwin" ]
then
  alias ip='ip -color=auto'
  alias ls='ls --color=auto'
  alias diff='diff --color=auto'
fi
alias grep='grep --color=auto'
alias d='dirs -v'

alias moon='curl wttr.in/Moon'
alias weather='curl wttr.in/Berlin'

cht() {
  curl cht.sh/$1
}

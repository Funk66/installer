#!/bin/sh

if [[ $- == *i* ]] && [ -z "$TMUX" ] && [ -z "$VIM" ]
then
  export TERM='tmux-256color'
  tmux -f ~/.config/tmux new-session
  exit
fi

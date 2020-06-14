#!/bin/sh

if [ -z "$TMUX" ] && [ -z "$VIM" ]
then
  export TERM='tmux-256color'
  tmux -f ~/.config/tmux new-session
fi

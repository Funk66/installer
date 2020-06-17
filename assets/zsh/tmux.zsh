#!/bin/sh

if [ -z "$TMUX" ] && [ -z "$VIM" ]
then
  tmux -f ~/.config/tmux new-session
fi

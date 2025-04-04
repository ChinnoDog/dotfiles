#!/bin/sh
# Configure the behavior of the bash prompt

# https://askubuntu.com/questions/339546/how-do-i-see-the-history-of-the-commands-i-have-run-in-tmux#answer-339925

# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups

# append history entries..
shopt -s histappend

# After each command, save and reload history
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# After each command save the history but don't reload it
echo $PROMPT_COMMAND | if ! grep "^history -a" >/dev/null; then 
  export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
fi


#!/bin/sh

alias watchdropbox="inotifywait -m -r -e modify,close_write,move,create,delete $HOME/Dropbox"

#!/bin/bash

set -o vi
export PATH=$PATH:~/

export MOZCONFIG=~/CoolScripts/mozconfig
export VISUAL=vim
export EDITOR="$VISUAL"

bind -m vi-insert "\C-l":clear-screen

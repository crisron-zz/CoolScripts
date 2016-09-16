#!/bin/bash

set -o vi
export PATH=$PATH:~/
export PATH=$PATH:~/GeeksForGeeks/bin
export PATH=$PATH:/usr/local/opt/go/libexec/bin

export MOZCONFIG=~/CoolScripts/mozconfig
export VISUAL=vim
export EDITOR="$VISUAL"

bind -m vi-insert "\C-l":clear-screen

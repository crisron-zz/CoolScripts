#!/bin/bash

set -o vi
export PATH=$PATH:~/
export PATH=$PATH:~/GeeksForGeeks/bin
export PATH=$PATH:/usr/local/opt/go/libexec/bin

bind -m vi-insert "\C-l":clear-screen

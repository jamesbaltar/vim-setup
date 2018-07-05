#!/bin/bash

tmux new-session -d 'vim'
tmux split-window -h
tmux split-window -v
tmux new-window 'mutt'
tmux -2 attach-session -d

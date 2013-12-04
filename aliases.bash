#!/bin/bash
alias gd='godir'
alias gf='gofile'
alias ef='execfile'
alias vi='vim'
ssh_with_tmux() {
  ssh $1 -t tmux
}
alias ssht=ssh_with_tmux

#!/bin/sh
#
# Copyright (c) 2013, Three Ocean (to@bcloud.us). All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the <organization> nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# Check OS type
platform='unknow'
os=$(uname)
if [ $os = 'Linux' ]; then
  platform='linux'
elif [ $os = 'Darwin' ]; then
  platform='apple'
fi

# color prompt
if [ "$WINDOW" ]; then
  PS1='\[\033[01;32m\]\u@\h:\[\033[01;33m\]\w\[\033[00;36m\][W$WINDOW]\$ \[\033[00m\]'
else
  PS1='\[\033[01;32m\]\u@\h:\[\033[01;33m\]\w\[\033[00m\]\$ \[\033[00m\]'
fi

# Color
export CLICOLOR=1
if [ $platform = 'apple' ]; then
  export LSCOLORS='GxFxBxDxCxegedabagacad'
  alias ls='ls -GFh'
elif [ $platform = 'linux' ]; then
  export LS_COLORS='di=36:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
  alias ls='ls --color=auto'
fi

# Alias definitions.
if [ -f ~/.bash/aliases.bash ]; then
  . ~/.bash/aliases.bash
fi

# Helper procedure
if [ -f ~/.bash/helper.bash ]; then
  . ~/.bash/helper.bash
fi

# Personal bashrc
if [ -f ~/.bash_$USER ]; then
  . ~/.bash_$USER
fi

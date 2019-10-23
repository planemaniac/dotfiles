#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[[ -f ~/.extend.bashrc ]] && . ~/.extend.bashrc

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# Tmux
ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
		tmux rename-window "$(echo $* | rev | cut -d ' ' -f1 | rev | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

# Exports
export EDITOR=vim
export PATH=$PATH:/home/planemaniac/.local/bin

git_branch () { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'; }
HOST='\[\033[02;36m\]\]`whoami` '
TIME='\[\033[01;32m\]'
LOCATION='\[\033[01;34m\]`pwd | sed "s#^/home/$(whoami)#~#"`'
BRANCH=' \[\033[00;33m\]$(git_branch)\[\033[00m\]\n'
PS2='\[\033[01;32m\]> \[\033[00m\]'
PS1=$HOST$LOCATION$BRANCH$PS2

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias less='less -R'
alias r2a='r2 -AA'

# Command Colors
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
	alias diff='diff --color=auto'

	alias grepc='grep --color=always'
	alias diffc='diff --color=always'

	alias lsc='ls --color=always'
	alias llc='ll --color=always'
	alias lac='la --color=always'
	alias lc='l --color=always'
fi

alias py="python2"
alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'
alias tmux='tmux -2'

alias noaslr='setarch `uname -m` -R /bin/bash'

source <(kitty + complete setup bash)

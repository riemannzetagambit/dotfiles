# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# for homebrew
PATH="/usr/local/bin::$PATH"
# sra toolkit setup
export PATH="$HOME/software/sratoolkit.2.9.6-1-mac64/bin:$PATH"
# for LOCAL (--user) pip installation, specific to Mac OS X
export PATH=/Users/dstone/Library/Python/3.9/bin:$PATH
# export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.9/site-packages
export PYTHONPATH=$PYTHONPATH:/Users/dstone/Library/Python/3.9/lib/python/site-packages

# define colors for bash prompt
# the extra brackets will fix formatting issues with scrolling through history commands
# see
# http://superuser.com/questions/382456/why-does-this-bash-prompt-sometimes-keep-part-of-previous-commands-when-scrollin?newreg=bb911559f2db403aa7e75b3aed5f1240
# 2nd and 3rd answers
BCYAN='\[\e[1;36m\]' 
CYAN='\[\e[0;36m\]'
BRED='\[\e[1;31m\]' 
RED='\[\e[0;31m\]'
YELLOW='\[\e[0;33m\]'
NORMAL='\[\e[m\]'
# If id command returns zero, you’ve root access.
if [ $(id -u) -eq 0 ];
	then # you are root, set red colour prompt
	 	 PS1="${BRED}\u${YELLOW}@${RED}\h:\w${NORMAL}# "
 	 else # normal
		 PS1="${BCYAN}\u${YELLOW}@${CYAN}\h:\w${NORMAL}$ "
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# do this after PS1 has been set
# git stuff
# for displaying git info in command line
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_THEME=Custom
source ~/.bash-git-prompt/gitprompt.sh
source ~/.git-completion.bash


# my default editor
export EDITOR=vim

# for virtualenvwrapper, which gives tab completion for virtualenvs with workon
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev
source /usr/local/bin/virtualenvwrapper.sh

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

#took this out of if statement above, arch linux iffy with dircolors, directly aliasing
#alias ls='ls -G --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
# color==auto doesn't work on OS X
alias ls='ls -G'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias gcc='gcc -Wextra -Wall -ansi -pedantic -o foo.out'
alias vi='vim'
alias sshcmu='ssh dstone@unix.andrew.cmu.edu'
alias sshresearch='ssh dstone@qwea.math.cmu.edu'
alias hello='echo "Hello David.  It is going to be alright.  Take a deep breath, the world is only what you make it.  There is no meaning except what you put there.  If you remember this, you might notice that the world is not against you, but is a retro-fitted mould that might not be suitable for your mind patterns.  So, make it what you will.  Mould the mould. Or break it, to be cliche.  Have a nice day."'
alias ..='cd ..'
alias ll='ls -al'
alias lld='ls -ld */'
alias late='ls -ltr'
alias wpa_go='wpa_supplicant -iwlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf -B'
alias pyrefox='firefox -P incognito'
alias top='htop'
# for mysql
alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin

#have bash completion enabled under arch, adding following lines just to make man and sudo completion insured
complete -cf sudo
complete -cf man

#eval `dircolors -b .colorsrc`
#this should set the ls colors appropriately
# this is how you set ls output on OS X
export CLICOLOR=1
# use yellow for directories
export LSCOLORS=Dxfxcxdxbxegedabagacad
#export LSCOLORS=Exfxcxdxbxegedabagacad
LS_COLORS=$LS_COLORS:'di=1;35:' ; export LS_COLORS

#should start X if you log in from console on tty1 AND you don't have X already running
#ideally makes me a super lightweight pretentious asshole who doesn't even need a display manager for login
if [[ $(tty) = /dev/tty1 ]] && [[ -z "$DISPLAY" ]]; then
	exec startx
fi

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto --group-directories-first'
alias ll="exa -lh --group-directories-first"
alias la="exa -ah --group-directories-first"
alias edit="emacs --no-desktop -nw"
alias ec="emacsclient -c"
alias ect="emacsclient -t"

PS1='\[\033[01;31m\][\[\033[01;36m\]\h\[\033[01;32m\]@\[\033[01;34m\]\u \[\033[01;33m\]\w\[\033[01;31m\]]\e[m\]$ '

alias ..='cd ..'

alias minesweeper='~/projects/programming/minesweeper/minesweeper.py'

source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

# add the .scripts folder to the PATH
PATH=/home/mael/.scripts:$PATH

# fuzzy change directory
c(){
    if [[ $1 ]]
    then
	cd $1
    else
	directory=$(fd --type directory | fzf-tmux -p -i --preview="tree -L 2 -C {}")
	if [[ $directory != "" ]]
	then
	    cd $directory
	    exa -lh
	fi
    fi
}

# fuzzy file finder and editor
e(){
    if [[ $1 ]]
    then
	emacs -nw $1
    else
	files=$(fzf-tmux -p -i --preview="bat --color always --theme TwoDark --style numbers {}")
	[[ $files == "" ]] || emacs -nw $files
    fi
}

# fuzzy file finder and editor
o(){
    if [[ $1 ]]
    then
	xdg-open $1 &
    else
	files=$(fzf-tmux -p --preview="bat --color always --theme TwoDark --style numbers {}")
	[[ $files == "" ]] || xdg-open $files &
    fi
}

export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 1) # red
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

export PATH=$PATH:/~/.scripts

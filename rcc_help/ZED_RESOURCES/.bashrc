# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

white () {
        PS1='\[\e[1;37m\][\u@\h \W]\$\[\e[m\]\[\e[0;37m\] '
}


green () {
        PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[m\]\[\e[0;32m\] '
}

red () {
        PS1='\[\e[1;31m\][\u@\h \W]\$\[\e[m\]\[\e[0;31m\] '
}

grey () {
    PS1='[\u@\h \W]\$\e[0m '
}


alias xterm2=' xterm -fs 11 -fa "Luxi Mono" -bg black -fg orange '
alias xterm1=' xterm -fs 11 -fa "Luxi Mono" -bg black -fg green '
alias xterm3=' xterm -fs 11 -fa "Luxi Mono" -bg black -fg cyan '
alias emacs_='TERM=xterm emacs -nw -q '

LS_COLORS=$LS_COLORS:'di=1;33:*.cc=1;92:ex=1;96:' ; export LS_COLORS

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/lib
export PATH="~/.local/bin:$PATH"



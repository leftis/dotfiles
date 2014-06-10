# aliases.zsh: Sets up aliases which make working at the command line easier.
# P.C. Shyamshankar <sykora@lucentbeing.com>

# Looking around, and moving about.
alias gpush='git push origin master && git push production master'
alias gpull='git pull origin master && git pull production master'
alias ...=../..
alias d=cd ..
alias o='sublime'

# Some application shortcuts.
alias gr="grep -EiRn --color=tty"

# Git aliases
alias g="git"
alias gst="git st"
alias gauth="git shortlog -s -n"
alias ctags="`brew --prefix`/bin/ctags"

alias password='dd if=/dev/urandom bs=6 count=1 2> /dev/null | base64'
# Not exactly an alias, but a workaround for completion's sake.
which hub &> /dev/null; (( 1 - $? )) && function git() { hub "$@" }

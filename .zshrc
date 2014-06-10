# Exporting neovims bin
export VIMRUNTIME=/usr/local/Cellar/macvim/7.4-72/MacVim.app/Contents/Resources/vim/runtime

# Ssh agent
eval ssh-agent &> /dev/null && ssh-add &> /dev/null

# Clean utf-8
LC_CTYPE=en_US.UTF-8

# Locate zsh
Z=~/etc/zsh

# Set up a working environment.
source $Z/environment.zsh

# Set up some aliases
source $Z/aliases.zsh

# Set some options.
source $Z/options.zsh

# Define some functions.
source $Z/functions.zsh

# Set up the Z line editor.
source $Z/zle.zsh

# Set the prompt.
source $Z/prompt.zsh

# Set up some colors for directory listings.
if (( C == 256 )); then
    source $Z/ls_colors_256.zsh
fi

# Initialize the completion system.
source $Z/completion.zsh

# Rbenv export
export PATH="$HOME/.rbenv/bin:/usr/local/bin:$PATH"

# Rbenv
eval "$(rbenv init -)"

ulimit -n 4096 

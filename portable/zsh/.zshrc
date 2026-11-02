# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -U path cdpath fpath manpath
for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done


# Use emacs keymap as the default.
bindkey -e

# Add plugin directories to PATH and fpath
plugin_dirs=(
  fzf-tab zsh-abbr
)
for plugin_dir in "${plugin_dirs[@]}"; do
  path+="$HOME/.zsh/plugins/$plugin_dir"
  fpath+="$HOME/.zsh/plugins/$plugin_dir"
  for plugin_fpath_dir in \
    "$plugin_dir/share/zsh/plugins/$plugin_dir" \
    "$plugin_dir/share/zsh/site-functions" \
    "$plugin_dir/share/zsh/vendor-completions"; do
    [[ -d "$HOME/.zsh/plugins/$plugin_fpath_dir" ]] && fpath+="$HOME/.zsh/plugins/$plugin_fpath_dir"
  done
done
unset plugin_dir plugin_dirs plugin_fpath_dir


autoload -U compinit && compinit
source $HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history)


eval "$(zoxide init zsh )"

# Source plugins
plugins=(
  fzf-tab/fzf-tab.plugin.zsh zsh-abbr/share/zsh/zsh-abbr/zsh-abbr.plugin.zsh
)
for plugin in "${plugins[@]}"; do
  [[ -f "$HOME/.zsh/plugins/$plugin" ]] && source "$HOME/.zsh/plugins/$plugin"
done
unset plugin plugins

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="100000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

if [[ $options[zle] = on ]]; then
  source <(fzf --zsh)
fi

# Set shell options
set_opts=(
  HIST_FCNTL_LOCK APPEND_HISTORY EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST
  HIST_FIND_NO_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_DUPS HIST_IGNORE_SPACE
  SHARE_HISTORY NO_HIST_SAVE_NO_DUPS
)
for opt in "${set_opts[@]}"; do
  setopt "$opt"
done
unset opt set_opts

# Disable default completion menu
zstyle ':completion:*' menu no

# Preview directory contents when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

source $HOME/.zsh/plugins/zsh-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export EDITOR=vim

# Edit promt command in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Search matching command only
# TODO: test substring search to see if it is better than this or oh-my-zsh behaviour
#bindkey '^k' history-search-forward
#bindkey '^j' history-search-backward

# Search any part of command string
bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down

# Volta
export VOLTA_HOME=$HOME/.volta
export PATH=$PATH:$VOLTA_HOME/bin

# Load NVM and make it available
# TODO: make this unique per machine
#export NVM_DIR="$HOME/.nvm"
#[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
#[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# TODO: this is really slow on the work laptop
# Load goenv
#export GOENV_ROOT="$HOME/.goenv"
#export PATH="$GOENV_ROOT/bin:$PATH"
#eval "$(goenv init -)"
#export PATH="$GOROOT/bin:$PATH"
#export PATH="$PATH:$GOPATH/bin"

# rbenv is now managed by programs.rbenv in ruby.nix

eval "$(rbenv init - zsh)"

if [[ -r "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

eval "$(direnv hook zsh)"

alias -- gcm='git commit -m'
alias -- gco='git checkout'
alias -- ll='ls -la'
alias -- ls='ls --color'
# Named Directory Hashes
hash -d dls="$HOME/Downloads"
hash -d docs="$HOME/Documents"

source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)



source $HOME/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

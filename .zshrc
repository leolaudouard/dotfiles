HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select


eval "$(starship init zsh)"

source ${HOME}/zsh-plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ${HOME}/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ${HOME}/zsh-plugins/zsh-completions/zsh-completions.plugin.zsh
source ${HOME}/zsh-plugins/zsh-z/zsh-z.plugin.zsh
#source ${HOME}/zsh-plugins/fzf-z/fzf-z.plugin.zsh
source ${HOME}/zsh-plugins/fzf-tab/fzf-tab.plugin.zsh
source ${HOME}/zsh-plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ${HOME}/zsh-plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ${HOME}/zsh-plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Does not work
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

. $HOME/.asdf/asdf.sh

#. $HOME/.asdf/completions/asdf.bash

source ${HOME}/
export PATH=${HOME}/projects/diff-so-fancy:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.asdf/installs/golang/1.13.5/packages/bin$PATH
export PATH=$HOME/easymile/fleet-management/bin/.tools:$PATH
export PATH="${PATH}:${HOME}/.krew/bin"
eval $(thefuck --alias)
source <(kubectl completion zsh)
source <(helm completion zsh)
alias k=kubectl
alias l="ls -alF"
source ~/easymile/shell-utils/zshrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export EM_LOCAL_PROJECTS_DIR=~/easymile/
source ${HOME}/git-subrepo/.rc
source ${HOME}/projects/kube-ps1/kube-ps1.sh
PROMPT='$(kube_ps1)'$PROMPT
kubeoff
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
alias watch='watch '
alias iex='iex --erl "-kernel shell_history enabled"'
export PATH=$PATH:${HOME}/bin/gradle/gradle-7.4.2/bin

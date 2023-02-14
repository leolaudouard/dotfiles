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

source $HOME/.asdf/asdf.sh

export PATH=${HOME}/tools/git-fuzzy/bin:$PATH
export PATH=${HOME}/projects/diff-so-fancy:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.asdf/installs/golang/1.13.5/packages/bin$PATH
export PATH=$HOME/easymile/fleet-management/bin/.tools:$PATH
export PATH="${PATH}:${HOME}/.krew/bin"
source <(kubectl completion zsh)
source <(helm completion zsh)
alias k=kubectl
alias l="ls -alF"
source ~/easymile/shell-utils/zshrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export EM_LOCAL_PROJECTS_DIR=~/easymile/
source ${HOME}/projects/git-subrepo/.rc

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
alias watch='watch '
alias iex='iex --erl "-kernel shell_history enabled"'
export PATH=$PATH:${HOME}/bin/gradle/gradle-7.4.2/bin


spawn_window()
{
    name=$1
    cmd=$2
    # TODO(pht) I could not find a way to avoid spliting the first window. My
    # shell-fu is not good enough.
    # This should return the number of open windows:
    #   tmux list-windows -t "$session" -F "#{window_panes}"
    # But I could not find a way to to test the command output and do an `if xx != "1"`
    tmux split-window -t "$window"
    tmux rename-window "$name"
    tmux send-keys -t "$name" "$cmd" C-m
}

line_dispatcher()
{
    spawn_window "line-dispatcher" "cd kotlin-project/line-dispatcher && ./gradlew run"
}

sitecc_backend()
{
    spawn_window "sitecc-backend" "./bin/launch_sitecc"
}

todo() {
    sitecc_backend
    line_dispatcher
}

alias g=./gradlew
alias python=python3

alias gp="git pull --prune"
alias gb="git checkout -"

# Main branch related, 'develop' here
alias grd="git rebase develop"
alias grdi="git rebase -i develop"
alias gcd="git checkout develop"
alias docker-compose="docker compose"


glmr() {
  GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  HEAD_REPO=$(git remote get-url origin 2>/dev/null | sed 's/.*://;s/.git$//' || echo "")
  UPSTREAM_REPO=$(git remote get-url upstream 2>/dev/null | sed 's/.*://;s/.git$//' || echo "")
  if [ ! -z "$UPSTREAM_REPO" ]
  then
    glab mr create --repo=$UPSTREAM_REPO --head=$HEAD_REPO -b $GIT_BRANCH -s $GIT_BRANCH -f -y -a leo.laudouard
  else
    glab mr create --head=$HEAD_REPO -s $GIT_BRANCH -f -y -a leo.laudouard
  fi
}

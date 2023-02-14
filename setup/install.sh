# Create vim stuff
mkdir ~/.vim/undodir
touch ~/.viminfo


chsh -s "$(which zsh)"

DOTFILES_PATH=$HOME/dotfiles


ln -S "$HOME/.vimrc" "$DOTFILES_PATH/.vimrc" 
ln -S "$HOME/.ideavimrc" "$DOTFILES_PATH/idea/.ideavimrc" 
ln -S "$HOME/.zshrc" "$DOTFILES_PATH/.zshrc"
ln -S "$HOME/.tmux.conf" "$DOTFILES_PATH/.tmux.conf"
ln -S "$HOME/.gitconfig" "$DOTFILES_PATH/.gitconfig"
mkdir "$HOME/.config"
ln -S "$HOME/.config/starship.toml" "$DOTFILES_PATH/starship.toml"


"$DOTFILES_PATH/setup/apt.sh"
"$DOTFILES_PATH/setup/snap.sh"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Zsh utils

mkdir "$HOME/zsh-plugins"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$HOME/zsh-plugins/fast-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/zsh-plugins/zsh-autosuggestions"
git clone https://github.com/agkozak/zsh-z.git "$HOME/zsh-plugins/zsh-z"
git clone https://github.com/Aloxaf/fzf-tab.git "$HOME/zsh-plugins/fzf-tab"
git clone https://github.com/jeffreytse/zsh-vi-mode.git "$HOME/zsh-plugins/zsh-vi-mode"
git clone https://github.com/zsh-users/zsh-history-substring-search.git "$HOME/zsh-plugins/zsh-history-substring-search"
git clone https://github.com/zsh-users/zsh-completions.git "$HOME/zsh-plugins/zsh-completions"

TOOLS_DIR="$HOME/tools"
mkdir "$TOOLS_DIR"

git clone https://github.com/bigH/git-fuzzy.git "$TOOLS_DIR/git-fuzzy"
git clone https://github.com/elixir-lsp/elixir-ls.git "$TOOLS_DIR/elixir-ls"

cd "$TOOLS_DIR/elixir-ls"
mix deps.get
MIX_ENV=prod mix compile
MIX_ENV=prod mix elixir_ls.release -o ./rel/

# TODO: Move this to tools dir
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2

git clone https://github.com/so-fancy/diff-so-fancy.git "$TOOLS_DIR/diff-so-fancy"
git clone https://github.com/jonmosco/kube-tmux.git "$TOOLS_DIR/kube-tmux"
git clone https://github.com/ingydotnet/git-subrepo.git "$TOOLS_DIR/git-subrepo"



# Terminator

sudo add-apt-repository ppa:mattrose/terminator
sudo apt update
sudo apt install terminator
sudo update-alternatives --config x-terminal-emulator
gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/terminator
gsettings set org.gnome.desktop.default-applications.terminal exec-arg "-x"



git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack


# Python packages 
pip install pylint \
    pyright \
    isort \

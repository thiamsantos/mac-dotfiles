#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

mkdir -p "$HOME/dotfiles"

if [[ $(command -v brew) == "" ]]; then
    echo "Installing Hombrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Updating Homebrew"
    brew update
fi

brew install git
brew install stats
brew install terraform
brew install awscli
brew install direnv
brew install asdf
brew install coreutils
brew install gnupg
brew install gnu-tar
asdf_folder="$HOME/.asdf"

    if [ ! -d "$asdf_folder/plugins/nodejs" ]
    then
        asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    fi

    if [ ! -d "$asdf_folder/plugins/yarn" ]
    then

asdf plugin-add yarn
    fi



brew install jq
brew install wget
brew install --cask iterm2
brew install --cask arc
brew install --cask 1password
brew install --cask todoist
brew install --cask zoom
brew install --cask docker
brew install --cask raycast
brew install --cask spotify
brew install --cask slack
brew install --cask height

mkdir -p "$HOME/.config/git"
ln -sf "$HOME/dotfiles/files/gitconfig" "$HOME/.config/git/config"

mkdir -p "$HOME/dev/github/finbits"
mkdir -p "$HOME/dev/github/thiamsantos"

if ! [ -x "$(command -v node)" ]
then
    asdf install nodejs 16.14.0
    asdf global nodejs 16.14.0
fi

brew install zsh

    if [ ! -r "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]
    then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi

    mkdir -p "$HOME/.zsh_functions"
    mkdir -p "$HOME/.oh-my-zsh/custom/themes"
    mkdir -p "$HOME/.oh-my-zsh/custom/plugins"

    zsh_autosuggestions_folder="$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

    if [ ! -d "$zsh_autosuggestions_folder" ]
    then
        git clone https://github.com/zsh-users/zsh-autosuggestions $zsh_autosuggestions_folder
    fi

    zsh_fzf_tab="$HOME/.oh-my-zsh/custom/plugins/fzf-tab"

    if [ ! -d "$zsh_fzf_tab" ]
    then
        git clone https://github.com/Aloxaf/fzf-tab $zsh_fzf_tab
    fi

    zsh_fast_syntax_highlighting="$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting"

    if [ ! -d "$zsh_fast_syntax_highlighting" ]
    then
        git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $zsh_fast_syntax_highlighting
    fi

    dracula_theme="$HOME/src/dracula-zsh-theme"

    if [ ! -d "$dracula_theme" ]
    then
        git clone https://github.com/dracula/zsh.git $dracula_theme
        ln -s "$dracula_theme/dracula.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/dracula.zsh-theme"
    fi

    dracula_highlighting="$HOME/src/dracula-zsh-syntax-highlighting"

    if [ ! -d "$dracula_highlighting" ]
    then
        git clone https://github.com/dracula/zsh-syntax-highlighting.git $dracula_highlighting
    fi

    ln -sf "$HOME/dotfiles/files/zshrc" "$HOME/.zshrc"

brew install postgresql@13
brew install xclip

mkdir -p "$HOME/.vim/autoload"
    plug_file="$HOME/.vim/autoload/plug.vim"
    plug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    if [ ! -e "$plug_file" ]
    then
        wget -O $plug_file $plug_url
    fi

    ln -sf "$HOME/dotfiles/files/vimrc" "$HOME/.vimrc"

brew install docker-compose

#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

mkdir -p "$HOME/.dotfiles"
mkdir -p "$HOME/bin"
mkdir -p "$HOME/src"
mkdir -p "$HOME/dev/finbits"
mkdir -p "$HOME/dev/thiamsantos"
mkdir -p "$HOME/.docker/cli-plugins"
mkdir -p "$HOME/.config/doom"

log_info() {
    echo "##"
    echo "##=> $1"
    echo "##"

}

brew_install() {
    log_info "Installing $1"
    brew install $1
}

brew update

brew_install git-delta
brew_install antigen
brew_install asdf
brew_install autoconf
brew_install awscli
brew_install coreutils
brew_install direnv
brew_install docker-compose
brew_install fop
brew_install fzf
brew_install git
brew_install gnu-tar
brew_install gnupg
brew_install go
brew_install jq
brew_install libxslt
brew_install openssl@1.1
brew_install postgresql@13
brew_install stow
brew_install terraform
brew_install unzip
brew_install wget
brew_install wxwidgets
brew_install zsh
brew_install vim
brew_install ripgrep
brew_install tldr
brew_install fd
brew_install editorconfig
brew_install pandoc
brew_install shellcheck
brew_install stylelint
brew_install isort
brew_install python@3.11
brew_install pipenv

brew install --cask 1password
brew install --cask arc
brew install --cask docker
brew install --cask figma
brew install --cask height
brew install --cask iterm2
brew install --cask raycast
brew install --cask slack
brew install --cask spotify
brew install --cask stats
brew install --cask todoist
brew install --cask zoom

pip3 install -U pytest
pip3 install -U nose

. $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh

asdf_folder="$HOME/.asdf"

if [ ! -d "$asdf_folder/plugins/nodejs" ]
then
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
fi

if [ ! -d "$asdf_folder/plugins/yarn" ]
then
    asdf plugin add yarn
fi

if [ ! -d "$asdf_folder/plugins/erlang" ]
then
    asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
fi

if [ ! -d "$asdf_folder/plugins/elixir" ]
then
   asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
fi


if [ ! -d "$asdf_folder/plugins/rust" ]
then
    asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git
fi

asdf plugin update --all

if ! [ -x "$(command -v node)" ]
then
    log_info "Installing nodejs"
    asdf install nodejs 18.12.1
    asdf global nodejs 18.12.1
fi

if ! [ -x "$(command -v yarn)" ]
then
    log_info "Installing yarn"
    asdf install yarn 1.22.19
    asdf global yarn 1.22.19
fi

if ! [ -x "$(command -v erl)" ]
then
    log_info "Installing erlang"
    asdf install erlang 25.3
    asdf global erlang 25.3
fi

if ! [ -x "$(command -v elixir)" ]
then
    log_info "Installing elixir"
    asdf install elixir 1.14.4-otp-25
    asdf global elixir 1.14.4-otp-25
fi

if ! [ -x "$(command -v rustc)" ]
then
    log_info "Installing rust"
    asdf install rust 1.70.0
    asdf global rust 1.70.0
fi

dracula_highlighting="$HOME/src/dracula-zsh-syntax-highlighting"

if [ ! -d "$dracula_highlighting" ]
then
    git clone https://github.com/dracula/zsh-syntax-highlighting.git $dracula_highlighting
fi

log_info "Setup symlinks"
stow --verbose --target=$HOME git zsh asdf vim
stow --verbose --target=$HOME/bin dot
stow --verbose --target="$HOME/.config/doom" doom
ln -sfn /opt/homebrew/opt/docker-compose/bin/docker-compose "$HOME/.docker/cli-plugins/docker-compose"

log_info "Installing emacs"
brew tap railwaycat/emacsmacport
brew install --cask emacs-mac

doom_emacs_folder="$HOME/.config/emacs"

if [ ! -d "$doom_emacs_folder" ]
then
    log_info "Installing doom emacs"
    git clone --depth 1 https://github.com/doomemacs/doomemacs $doom_emacs_folder
    $doom_emacs_folder/bin/doom install
fi

echo "Setup completed!"

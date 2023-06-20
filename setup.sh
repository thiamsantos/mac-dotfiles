#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

mkdir -p "$HOME/.dotfiles"
mkdir -p "$HOME/bin"
mkdir -p "$HOME/src"
mkdir -p "$HOME/dev/finbits"
mkdir -p "$HOME/dev/thiamsantos"

if [[ $(command -v brew) == "" ]]; then
    echo "Installing Hombrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Updating Homebrew"
    brew update
fi

brew install antigen
brew install asdf
brew install autoconf
brew install awscli
brew install coreutils
brew install direnv
brew install docker-compose
brew install fop
brew install fzf
brew install git
brew install gnu-tar
brew install gnupg
brew install go
brew install jq
brew install libxslt
brew install openssl@1.1
brew install postgresql@13
brew install stats
brew install stow
brew install terraform
brew install unzip
brew install wget
brew install wxwidgets
brew install zsh

brew install --cask 1password
brew install --cask arc
brew install --cask docker
brew install --cask figma
brew install --cask height
brew install --cask hiddenbar
brew install --cask iterm2
brew install --cask raycast
brew install --cask slack
brew install --cask spotify
brew install --cask todoist
brew install --cask whichspace
brew install --cask zoom

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

asdf plugin update --all

if ! [ -x "$(command -v node)" ]
then
    asdf install nodejs 18.12.1
    asdf global nodejs 18.12.1
fi

stow --verbose --target=$HOME git zsh

echo "Setup completed!"

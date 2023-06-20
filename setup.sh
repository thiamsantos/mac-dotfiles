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
brew install jq
brew install libxslt
brew install openssl@1.1
brew install postgresql@13
brew install stats
brew install terraform
brew install unzip
brew install wget
brew install wxwidgets
brew install zsh
brew install zsh-autosuggestions

brew install --cask 1password
brew install --cask arc
brew install --cask docker
brew install --cask height
brew install --cask iterm2
brew install --cask raycast
brew install --cask slack
brew install --cask spotify
brew install --cask todoist
brew install --cask zoom

. $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add yarn
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin update --all

# if ! [ -x "$(command -v node)" ]
# then
#     asdf install nodejs 18.12.1
#     asdf global nodejs 18.12.1
# fi
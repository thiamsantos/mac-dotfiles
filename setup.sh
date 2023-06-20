#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

mkdir -p "$HOME/.dotfiles"
mkdir -p "$HOME/bin"
mkdir -p "$HOME/src"
mkdir -p "$HOME/dev/finbits"
mkdir -p "$HOME/dev/thiamsantos"

brew update

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
brew install vim
brew install ripgrep
brew install tldr
brew install fd

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


if [ ! -d "$asdf_folder/plugins/rust" ]
then
    asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git
fi

asdf plugin update --all

if ! [ -x "$(command -v node)" ]
then
    echo "Installing nodejs"
    asdf install nodejs 18.12.1
    asdf global nodejs 18.12.1
fi

if ! [ -x "$(command -v yarn)" ]
then
    echo "Installing yarn"
    asdf install yarn 1.22.19
    asdf global yarn 1.22.19
fi

if ! [ -x "$(command -v erl)" ]
then
    echo "Installing erlang"
    asdf install erlang 25.3
    asdf global erlang 25.3
fi

if ! [ -x "$(command -v elixir)" ]
then
    echo "Installing elixir"
    asdf install elixir 1.14.4-otp-25
    asdf global elixir 1.14.4-otp-25
fi

if ! [ -x "$(command -v rustc)" ]
then
    echo "Installing rust"
    asdf install rust 1.70.0
    asdf global rust 1.70.0
fi

stow --verbose --target=$HOME git zsh asdf vim

dracula_highlighting="$HOME/src/dracula-zsh-syntax-highlighting"

if [ ! -d "$dracula_highlighting" ]
then
    git clone https://github.com/dracula/zsh-syntax-highlighting.git $dracula_highlighting
fi

brew tap railwaycat/emacsmacport
brew install --cask emacs-mac

doom_emacs_folder="~/.config/emacs"

if [ ! -d "$doom_emacs_folder" ]
then
    git clone --depth 1 https://github.com/doomemacs/doomemacs $doom_emacs_folder
    $doom_emacs_folder/bin/doom install
fi

$doom_emacs_folder/bin/doom doctor

echo "Setup completed!"

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

source $HOMEBREW_PREFIX/share/antigen/antigen.zsh

source $HOME/src/dracula-zsh-syntax-highlighting/zsh-syntax-highlighting.sh

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

antigen use oh-my-zsh

antigen bundle aws
antigen bundle asdf
antigen bundle direnv
antigen bundle fzf
antigen bundle mix
antigen bundle terraform
antigen bundle rust
antigen bundle yarn

antigen bundle Aloxaf/fzf-tab
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen theme dracula/zsh

antigen apply

export ERL_AFLAGS="-kernel shell_history enabled"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.config/emacs/bin"
export EDITOR="vim"

# alias xclip="xclip -selection c"
alias mt="mix format && mix test && mix credo"
alias ga="git add"
alias gap="git add -p"
alias gc="git commit -m"
alias gca="git commit --amend --no-edit"
alias gm="git merge"
alias gck="git checkout"
alias gpl="git pull --rebase"
alias gp="git push origin HEAD"
alias gpf="git push origin HEAD --force-with-lease"
alias gb="git checkout -b"
alias gmb="git symbolic-ref --short refs/remotes/origin/HEAD | sed 's@^origin/@@'"
alias gcb="git rev-parse --abbrev-ref HEAD"

gsup() {
  local current_branch="$(gcb)"

  git branch --set-upstream-to="origin/$current_branch" "$current_branch"
}

gsync() {
  local main_branch="$(gmb)"

  gck "$main_branch" && gpl && gck - && gm "$main_branch"
}

grsync() {
  local main_branch="$(gmb)"

  gck "$main_branch" && gpl && gck - && git rebase "$main_branch"
}

encrypt_value() {
  echo -n "Enter value: "
  stty -echo
  read value
  echo
  stty echo

  echo -n "Enter secret: "
  stty -echo
  read secret
  echo
  stty echo

  echo $value | openssl aes-256-cbc -a -salt -k $secret -pbkdf2 | xclip
  echo 'Encrypted value copied to clipboard!'
}

decrypt_value() {
  echo -n "Enter encrypted value: "
  stty -echo
  read encrypted_value
  echo
  stty echo

  echo -n "Enter secret: "
  stty -echo
  read secret
  echo
  stty echo

  echo $encrypted_value | openssl aes-256-cbc -d -a -k $secret -pbkdf2 | xclip
  echo 'Value copied to clipboard!'
}

genpasswd() {
  local size=${1:-64}

  strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $size | tr -d '\n'
}

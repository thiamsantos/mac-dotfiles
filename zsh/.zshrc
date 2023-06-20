source $HOMEBREW_PREFIX/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle aws
antigen bundle asdf
antigen bundle direnv
antigen bundle fzf
antigen bundle mix
antigen bundle genpass
antigen bundle terraform
# antigen bundle rust
antigen bundle yarn

antigen bundle Aloxaf/fzf-tab
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen theme dracula/zsh

antigen apply

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

# alias xclip="xclip -selection c"
alias mt="mix format && mix test && mix credo"

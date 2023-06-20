source $HOMEBREW_PREFIX/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle asdf
antigen bundle direnv
antigen bundle dracula/zsh
antigen bundle fzf
antigen bundle terraform

antigen bundle Aloxaf/fzf-tab
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

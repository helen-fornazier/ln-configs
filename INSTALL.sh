#!/bin/bash

# ===============
# VIMRC
# ===============

# Install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Create a sym link
ln -s $PWD/.vimrc ~/.vimrc

# Create directory for vim backup files
mkdir -p ~/.vim/backup

# Install the plugins from command line
vim +PluginInstall +qall

# ===============
# TMUX
# ===============

# Create a sym link
ln -s $PWD/.tmux.conf ~/.tmux.conf

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install plugins
tmux source ~/.tmux.conf
~/.tmux/plugins/tpm/bin/install_plugins

echo "Execute: apt install xsel (or xclip): in order to yank to clipboard"

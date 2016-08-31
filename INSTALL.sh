# Install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Create a sym link
ln -s $PWD/.vimrc ~/.vimrc

# Create directory for vim backup files
mkdir -p ~/.vim/backup

# Install the plugins from command line
vim +PluginInstall +qall

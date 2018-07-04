#!/bin/bash

ROOT_DIR=`pwd`

sudo apt-get install -y \
	vim \
	tmux \
	git

mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Backup old vim folder and files
BACKUP_DATE=`date -d "today" +"%Y%m%d%H%M"`
if [ -d ~/.vim/ftplugin ]; then
	echo "Creating current ~/.vim/ftplugin backup..."
	mv ~/.vim/ftplugin ~/.vim/ftplugin.backup."$BACKUP_DATE"
	echo "Backup created: ""~/.vim/ftplugin.backup.""$BACKUP_DATE"
fi

if [ -e ~/.vimrc ]; then
	echo "Creating current ~/.vimrc backup..."
	mv ~/.vimrc ~/.vimrc.backup."$BACKUP_DATE"
	echo "Backup created: ""~/.vimrc.backup.""$BACKUP_DATE"

fi

ln -sf $ROOT_DIR/vim/ftplugin ~/.vim/ftplugin
echo "Linked ~/.vim/ftplugin"
ln -sf $ROOT_DIR/vimrc ~/.vimrc
echo "Linked ~/.vimrc"


# Setup tmux config
if [ -e ~/.tmux.conf ]; then
	echo "Creating current ~/.tmux.conf backup..."
	mv ~/.tmux.conf ~/.tmux.conf."$BACKUP_DATE"
	echo "Backup created: ""~/.tmux.conf.""$BACKUP_DATE"
fi

ln -sf $ROOT_DIR/tmux.conf ~/.tmux.conf
echo "Linked ~/.tmux.conf"

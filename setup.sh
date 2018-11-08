#!/bin/bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

sudo apt-get install -y \
	vim \
	tmux \
	build-essential \
	cmake \
	python-dev \
	python3-dev \
        flake8 \
	git \
	fonts-powerline \
        xclip # use for tmux copy buffer

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
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf $ROOT_DIR/tmux.conf ~/.tmux.conf
echo "Linked ~/.tmux.conf"


# Setup YouCompleteMe
git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
# Build ycm_core
git submodule update --init --recursive

setup_ycm_typescript() {
    sudo apt-get install -y npm
    sudo npm install -g typescript
    YCM_BUILD="$YCM_BUILD --js-completer"
}
setup_ycm_go() {
    if [ ! -x "$(command -v go)" ]; then
	echo "Go not found. Installing it now"
	sudo apt-get install -y wget
    	wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz
	sudo tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz
	rm go1.10.3.linux-amd64.tar.gz
	echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc
	export PATH=$PATH:/usr/local/go/bin
    fi
    YCM_BUILD="$YCM_BUILD --go-completer"
}


YCM_BUILD='--clang-completer'
while true; do
    read -p "[YouCompleteMe] Install TypeScript support [Y/n]" yn
    case $yn in
        [Yy]* ) setup_ycm_typescript; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "[YouCompleteMe] Install Go support [Y/n]?" yn
    case $yn in
        [Yy]* ) setup_ycm_go; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
cd ~/.vim/bundle/YouCompleteMe
./install.py $YCM_BUILD
echo "Built YouCompleteMe with \"$YCM_BUILD\" flags"

setup_vuejs_syntax_highlighting_support() {
    sudo apt-get install -y npm
    sudo npm i -g eslint eslint-plugin-vue
}

# Install VueJS(*.vue) Syntax Highlighing
while true; do
    read -p "Install VueJS(*.vue) Syntax Highlighting [Y/n]" yn
    case $yn in
        [Yy]* ) setup_vuejs_syntax_highlighting_support; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

if [[ ":$PATH:" == *":$ROOT_DIR/bin:"* ]]; then
  echo "Your PATH already includes $ROOT_DIR/bin"
else
  echo "export PATH=$PATH:$ROOT_DIR/bin" >> ~/.bashrc
  echo "$ROOT_DIR/bin was added in your PATH through ~/.bashrc"
fi

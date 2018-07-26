set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'

Plugin 'kien/ctrlp.vim' " fuzzy search

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-bufferline'
Plugin 'Valloric/YouCompleteMe'

Plugin 'leafgarland/typescript-vim'
Plugin 'jason0x43/vim-js-indent'
Plugin 'fatih/vim-go'
Plugin 'posva/vim-vue'

" Colorschemes
Plugin 'joshdick/onedark.vim'


call vundle#end()

filetype plugin indent on

" Setup
set nowrap
syntax on
set t_Co=256
set number " show line numbers
set background=dark 
colorscheme onedark

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

" Setup tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>


let g:airline_theme='angr'

" Use vim-js-indent instead of the builtin typescript indent in typescript-vim
let g:typescript_indent_disable = 1

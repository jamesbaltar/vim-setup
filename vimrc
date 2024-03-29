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
" Plugin 'bling/vim-bufferline'
Plugin 'Valloric/YouCompleteMe'

Plugin 'leafgarland/typescript-vim'
" Plugin 'jason0x43/vim-js-indent'
Plugin 'fatih/vim-go'
Plugin 'posva/vim-vue'
" Plugin 'nvie/vim-flake8'

" Plugin 'vim-syntastic/syntastic'
" Plugin 'maralla/validator.vim'
Plugin 'dense-analysis/ale'

" Colorschemes
" Plugin 'joshdick/onedark.vim'
Plugin 'rafi/awesome-vim-colorschemes'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Python code folding
Plugin 'tmhedberg/SimpylFold'

" For golang
" go get -u github.com/jstemmer/gotags
" Plugin 'taglist.vim'
Plugin 'majutsushi/tagbar'

call vundle#end()

filetype plugin indent on

" Setup
set nowrap
syntax on
set t_Co=256
set number relativenumber
set visualbell
set t_vb=
" set relativenumber
" set cursorline
"
set nu
set rnu

set background=dark
colorscheme onedark "gruvbox
let g:airline_theme='minimalist' "'gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

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

" Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Utils Mapping
nnoremap <C-n> i<Enter><Esc>h

nnoremap <Leader>b :CtrlPBuffer<CR>

" YCM
nnoremap <Leader>d :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader>r :YcmCompleter GoToReferences<CR>

nnoremap <Leader>b :CtrlPBuffer<CR>

" YCM
nnoremap <Leader>d :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader>r :YcmCompleter GoToReferences<CR>


" let g:ycm_python_binary_path = '/usr/bin/python3'

" Use vim-js-indent instead of the builtin typescript indent in typescript-vim
" let g:typescript_indent_disable = 1


" ==================================
" From https://stackoverflow.com/a/7321131
function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Bdi :call DeleteInactiveBufs()

autocmd BufWritePre * %s/\s\+$//e

set backupdir=/tmp// " <- for Linux
" set backupdir=$TMPDIR// " <- for Mac
set directory=/tmp// " <- for Linux
" set backupdir=$TMPDIR// " <- for Mac


" Syntastic =======
" execute pathogen#infect()
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0

" let g:syntastic_python_checkers = ['flake8', 'pylint', 'mypy']
" let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
" ======

" Validator ===========
" let g:validator_python_checkers = ['flake8', 'pylint']
" let g:validator_php_checkers = ['php', 'phpcs', 'phpmd']
" let g:validator_permament_sign = 1
" let g:validator_debug = 1
" let g:validator_python3_binary = '/Users/jbaltar/projects/env/bin/python'
" let g:validator_python_binary = '/Users/jbaltar/projects/env/bin/python'

let g:airline_highlighting_cache = 1
let g:airline_extensions = []

" ======ALE
let g:ale_linters = {'python': ['flake8', 'pylint', 'mypy'], 'php': ['php', 'phpcs', 'phpmod']}
let g:LanguageClient_useVirtualText = 0
" let g:ale_set_highlights = 0
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_format = '%linter%: %s'
let g:ale_python_flake8_executable = 'python -m flake8'
let g:ale_python_pylint_executable = 'python -m pylint'
let g:ale_python_pylint_options = '--load-plugins pylint_django'
let g:ale_python_mypy_executable = 'python -m mypy'
let g:ale_set_highlights = 0
"
" enable loading of .vimrc in current directory
set exrc


" let g:ycm_server_keep_logfiles = 1
" let g:ycm_server_log_level = 'debug'jjj
" let g:ycm_auto_trigger = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
set backspace=indent,eol,start

" Trigger configuration. You need to change this to something other than <tab>
" if you use one of the following:
" " - https://github.com/Valloric/YouCompleteMe
" " - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"   " If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"
" " If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"
let Tlist_Inc_Winwidth=0

nnoremap <F2> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
nnoremap <S-t> :tab split<CR>

autocmd BufNewFile,BufRead *.yaml.j2 set syntax=yaml


let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

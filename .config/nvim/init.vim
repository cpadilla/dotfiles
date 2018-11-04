"========================================
"   inti.vim
"   created by Christofer Padilla
"========================================

"========================================
"                Plugins
"========================================
" specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim' " additional ranger.vim dependency
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'

call plug#end()

" Plugin settings

" Use ranger when opening a directory
let g:NERDTreeHijackNetrw = 0
let g:ranger_replace_netrw = 1

"========================================
"                Settings
"========================================
set mouse=a
set clipboard+=unnamedplus
set nu

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab

"========================================
"                Commands
"========================================
" command to pipe selection into BC
" currently doesn't support multiple lines
" because of ^M somewhere along the way
function BC() range
    let ans = system('echo scale=6\;'.shellescape(join(getline(a:firstline, a:lastline), "\r")).'| bc')
    put =ans
endfunction
com -range=% -nargs=0 BC :<line1>,<line2>call BC()

"========================================
"                Remaps
"========================================
nnoremap ; $
vnoremap ; $

" map Ctrl+b to call BC() which pipes the current line or selection to BC
vnoremap <C-b> :BC<CR>
nnoremap <C-b> <S-V>:BC<CR>

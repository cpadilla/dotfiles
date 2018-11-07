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
Plug 'vim-airline/vim-airline-themes'
" auto complete
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }

" ale - linter / autocompletion / formatter
Plug 'w0rp/ale'

" auto formatter
Plug 'rhysd/vim-clang-format'

" surround vim
Plug 'tpope/vim-surround'

" nerd commenter
Plug 'scrooloose/nerdcommenter'

" ctags indexer
Plug 'vim-scripts/DfrankUtil'
Plug 'vim-scripts/vimprj'
Plug 'vim-scripts/indexer.tar.gz'

" A - for switching between source and header files
Plug 'vim-scripts/a.vim'

" debugger for neovim
Plug 'huawenyu/neogdb.vim'

call plug#end()

" Plugin settings

" Use ranger when opening a directory
let g:NERDTreeHijackNetrw = 0
let g:ranger_replace_netrw = 1

"========================================
"                Settings
"========================================
" reload files changed outside vim
set autoread
" Triger `autoread` when files changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" disable wrapping of long lines into multiple lines
set nowrap

set mouse=a
set clipboard+=unnamedplus
set nu

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" ==============================================================================
"                                  TABS
" ==============================================================================

" Alt+Tab to switch between tabs
nnoremap <A-Tab> :tabn<CR>
nnoremap <S-Tab> :tabp<CR>

" Alt+T to open new tab
map <A-t> :tabnew<Return>

"========================================
"                Swap files
"========================================
" Turn off swap files
set noswapfile
set nobackup
set nowb

"========================================
"                Commands
"========================================
" command to pipe selection into BC
" currently doesn't support multiple lines
" because of ^M somewhere along the way
function BC() range
    let ans = system('echo scale=6\;'.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| bc -l')
    normal '>
    put ='=='
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

"========================================
"                Folds
"========================================
set foldmethod=syntax
set foldnestmax=2

autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview

"========================================
"                Folds
"========================================
" Ignorecase when searching
set ignorecase

" incremental search - Vim starts searching when we start typing
set incsearch

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch


"========================================
"                Ale settings
"========================================

" autocompletion
let g:ale_completion_enabled = 1

let g:ale_cpp_clang_executable = 'clang++-5.0'

" linter
 let g:ale_linters = {
            \   'cpp': ['clang']
            \}
let g:ale_cpp_clang_options = '-std=c++1z -O0 -Wextra -Wall -Wpedantic -I /usr/include/eigen3'
"let g:ale_cpp_clangtidy_options = '-checks="cppcoreguidelines-*"'
"let g:ale_cpp_cpplint_options = ''
"let g:ale_cpp_gcc_options = ''
"let g:ale_cpp_clangcheck_options = ''
"let g:ale_cpp_cppcheck_options = ''

"========================================
"                Clang settings
"========================================

" Clang format - auto formatting
 
let g:clang_format#command = 'clang-format-3.8'
let g:clang_format#style_options = {
            \ "BreakBeforeBraces" : "Attach",
            \ "UseTab" : "Never",
            \ "IndentWidth" : 4,
            \ "ColumnLimit" : 100,
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AllowShortFunctionsOnASingleLine" : "false",
            \}

"========================================
"                CTags settings
"========================================
 
" change the stack pop to a more comfortable mapping
nnoremap <C-e> <C-]>

" CTAGS indexer
let g:indexer_disableCtagsWarning = 1


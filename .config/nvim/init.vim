"========================================
"   inti.vim
"   created by Christofer Padilla
"========================================

"========================================
"                Plugins
"========================================

" Automatically check for Plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'puremourning/vimspector'
Plug 'mason-org/mason.nvim'
Plug 'mason-org/mason-lspconfig.nvim'

Plug 'neovim/nvim-lspconfig' 
Plug 'simrat39/rust-tools.nvim'

Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim' " additional ranger.vim dependency
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Robitx/gp.nvim'
Plug 'numToStr/Comment.nvim'

" Colorschemes
Plug 'EdenEast/nightfox.nvim'
Plug 'joshdick/onedark.vim'
Plug 'Aryansh-S/fastdark.vim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'owickstrom/vim-colors-paramount'

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

" DWM for Vim
" Plug 'spolu/dwm.vim'

" A - for switching between source and header files
Plug 'vim-scripts/a.vim'
" Plug 'derekwyatt/vim-fswitch'

" debugger for neovim
" Plug 'sakhnik/nvim-gdb', { 'do': './install.sh' }
Plug 'huawenyu/neogdb.vim'

" Search utility
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

" Somewhere after plug#end()
:lua require('Comment').setup()

" Plugin settings
" GP.nvim plugin
:lua require('gp').setup()

" -- Mason Setup
:lua require("mason").setup({ ui = { icons = { package_installed = "", package_pending = "", package_uninstalled = "", }, } })
:lua require("mason-lspconfig").setup()

" Use ranger when opening a directory
let g:NERDTreeHijackNetrw = 0
let g:ranger_replace_netrw = 1

" Syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

let g:vimspector_enable_mappings = 'HUMAN'
packadd! vimspector
syntax enable
filetype plugin indent on

" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   highlight = {
"     enable = true,
"     custom_captures = {
"       -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
"       ["foo.bar"] = "Identifier",
"     },
"     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
"     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
"     -- Using this option may slow down your editor, and you may see some duplicate highlights.
"     -- Instead of true it can also be a list of languages
"     additional_vim_regex_highlighting = false,
"   },
" }
" EOF

" Change the color of YouCompleteMe autocomplete
highlight Pmenu ctermfg=0 ctermbg=15 guifg=#ffffff guibg=#000000

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

" Hide markdown syntax
set cole=3

set wrap

set mouse=a
set nu

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" Use airline powerline fonts
let g:airline_powerline_fonts = 1

" Always use system clipboard
set clipboard+=unnamedplus

" Spellchekc
" set spell spelllang=en_us



" Make fswitch work when headers and source files are in separate directories
" au BufEnter *.h let b:fswitchdst = 'c,cpp,m,cc' | let b:fswitchlocs = 'reg:|include.*|src/**'

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
    " let ans = system('echo scale=6\;'.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| bc -l')
    let ans = system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| bc -l')
    normal '>
    put ='=='
    put =ans
endfunction
com -range=% -nargs=0 BC :<line1>,<line2>call BC()

"========================================
"                Remaps
"========================================
map ; $

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" map Tab to Control+n
" inoremap <Tab> <c-n>
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
:verbose inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ CheckBackspace() ? "\<TAB>" :
    \ coc#refresh()
:verbose inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" map Ctrl+b to call BC() which pipes the current line or selection to BC
vnoremap + :BC<CR>
nnoremap + <S-V>:BC<CR>

" map control-backspace to delete the previous word
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" Search for visually selected text
vnorem // y/<C-r>"<CR>

" Remaps increment/decrement command to Alt-=/Alt--
nnoremap <A-=> <C-a>
nnoremap <A--> <C-x>

" Move between Windows with Alt + Arrow Keys
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR><Paste>

" Remap Ctrl A
map <C-a> <Esc>ggvG$

" Leader key shortcuts
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>j :lua vim.diagnostic.open_float()<CR>

" Silver searcher
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Telescope colorschemes
:nnoremap <Leader>pp :lua require'telescope.builtin'.colorscheme{}<cr>

" coc.nvim autocomplete
" inoremap <silent><expr> <c-space> coc#refresh()
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
" inoremap <silent><expr> <TAB>
      " \ coc#pum#visible() ? coc#pum#next(1) :
      " \ CheckBackspace() ? "\<Tab>" :
      " \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Fswitch keymap
" nnoremap <silent> <A-o> :FSHere<cr>
" Go to header file using ctags
nnoremap <silent> <A-o> :tag %<.h<cr>

"========================================
"                Folds
"========================================
hi Folded ctermbg=0

set foldmethod=syntax
" set foldnestmax=2

" autocmd BufWinLeave *.* mkview!
" autocmd BufWinEnter *.* silent! loadview

" Ignorecase when searching
" set ignorecase

" incremental search - Vim starts searching when we start typing
set incsearch

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Open all folds by default
set nofoldenable


"========================================
"                Ale settings
"========================================

" autocompletion
let g:ale_completion_enabled = 1

let g:ale_cpp_clang_executable = 'clang++-5.0'

" linter
let g:ale_linters = {
            \   'cpp': ['clang'],
            \   'rust': ['cargo', 'analyzer']
            \}
let g:ale_fixers = {
            \ 'rust': ['cargo']
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

colorscheme fastdark

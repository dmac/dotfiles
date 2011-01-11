" ====================
" General
" ====================
set nocompatible
set history=50
set incsearch
set autoread
set modeline
filetype plugin indent on

" ====================
" Colors and Skins
" ====================
if &t_Co > 2 || has("gui_running")
  syntax enable
  set hlsearch
endif

" ====================
" Plugins
" ====================
set runtimepath+=~/.vim/addons/NERD_tree
set runtimepath+=~/.vim/addons/NERD_commenter
set runtimepath+=~/.vim/addons/git-vim
set runtimepath+=~/.vim/addons/repeat
set runtimepath+=~/.vim/addons/surround
set runtimepath+=~/.vim/addons/taglist
set runtimepath+=~/.vim/addons/autoclose
set runtimepath+=~/.vim/addons/bufkill

" ====================
" Backups
" ====================
set nobackup
set nowritebackup
set noswapfile
"set backupdir=~/.vim/backup
"set backupcopy=yes

" ====================
" UI
" ====================
set ruler
set showcmd
set wildmenu
set wildmode=list:longest,full
set number

" ====================
" Highlights
" ====================
hi LineNr ctermfg=DarkGray ctermbg=Black
hi Comment ctermfg=cyan cterm=none
hi Directory ctermfg=cyan cterm=none
" better git diff colors
hi diffAdded ctermfg=DarkGreen ctermbg=Black
hi diffRemoved ctermfg=DarkRed ctermbg=Black
hi diffFile ctermfg=darkcyan ctermbg=Black

" ====================
" Visual Cues
" ====================
set showmatch
set ignorecase
set nohlsearch
set list listchars=trail:.,tab:>. " highlight trailing whitespace
highlight SpecialKey ctermfg=DarkGray ctermbg=Black

" ====================
" Text Formatting
" ====================
set autoindent
set smartindent
set backspace=2
set tabstop=4
set softtabstop=2
set shiftwidth=2
set textwidth=110
set expandtab
set nosmarttab

" ====================
" Mappings
" ====================
map Q g
let mapleader=","
nmap <LEADER>e :e **/*
nmap <LEADER>f :NERDTreeToggle<CR>
nmap <LEADER>t :TlistToggle<CR>
nmap <LEADER>d :BD<CR>
nnoremap <LEADER>b :b *

" Automatic brace and quote closing
inoremap {<CR>  {<CR>}<Esc>O
inoremap [<CR>  [<CR>]<Esc>O

" Underlining
nnoremap <LEADER>= yyp<C-v>$r=
nnoremap <LEADER>- yyp<C-v>$r-

" ====================
" Auto Commands
" ====================
if has("autocmd")
  autocmd BufWritePre * :%s/\s\+$//e           " strip trailing whitespace on save
  autocmd BufReadPost *                        " set cursor to the last position when opening
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif


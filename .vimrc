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
  syntax on
  set hlsearch
endif

" ====================
" Plugins
" ====================
set runtimepath+=~/.vim/addons/vim-addon-manager
call scriptmanager#Activate(["The_NERD_tree",
                           \ "surround",
                           \ "repeat",
                           \ "snipMate",
                           \ "git-vim",
                           \ "taglist"])

" ====================
" Backups
" ====================
set nobackup
set nowritebackup
set noswapfile
set backupdir=~/.vim/backup
set backupcopy=yes

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
hi LineNr ctermfg = DarkGray ctermbg=Black
hi Comment ctermfg=cyan cterm=none
hi Directory ctermfg=cyan cterm=none

" ====================
" Visual Cues
" ====================
set showmatch
set ignorecase
set list listchars=trail:.,tab:>. " highlight trailing whitespace
highlight SpecialKey ctermfg=DarkGray ctermbg=Black

" ====================
" Text Formatting
" ====================
set autoindent
set smartindent
set backspace=2
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
nmap <LEADER>e :e **/
nmap <LEADER>f :NERDTreeToggle<CR>
nmap <LEADER>t :TlistToggle<CR>

" Automatic brace and quote closing
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     [}

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


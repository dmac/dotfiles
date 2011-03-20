" ====================
" Plugins
" ====================
" I add my plugins to the runtime manually because
" calling pathogen#runtime_append_all_bundles increases
" the startup time of vim by a few seconds.
"set runtimepath+=~/.vim/bundle/The-NERD-tree
"set runtimepath+=~/.vim/bundle/The-NERD-Commenter
"set runtimepath+=~/.vim/bundle/git-vim
"set runtimepath+=~/.vim/bundle/vim-repeat
"set runtimepath+=~/.vim/bundle/vim-surround
"set runtimepath+=~/.vim/bundle/taglist
"set runtimepath+=~/.vim/bundle/bufkill
"set runtimepath+=~/.vim/bundle/Command-T
"set runtimepath+=~/.vim/bundle/supertab
set runtimepath+=~/.vim/bundle/vim-pathogen
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" ====================
" Plugin Options
" ====================
let g:CommandTCancelMap="<C-c>"                    " cancel out of CommandT with C-c
let g:SuperTabDefaultCompletionType="context"      " contextual autocomplete
let g:SuperTabContextDefaultCompletionType="<C-n>" " tab complete forward with autocomplete

let g:NERDTreeChDirMode=2 " change pwd when NERDTree root changes
let g:NERDChristmasTree=1 " more colorful NERDTree

" android configuration for javaimp plugin
if $ANDROID_HOME != ""
  let g:JavaImpPaths=$ANDROID_HOME."/platforms/android-7"
  let g:JavaImpDataDir=$HOME."/.javaimp"
end

" ====================
" General
" ====================
set nocompatible          " duh
set history=1000          " longer history
set incsearch             " perform search as you type
set autoread              " reload changed files when focus returns
set modeline              " enable modelines
filetype plugin indent on " detect filetypes

" ====================
" Colors and Skins
" ====================
if &t_Co > 2 || has("gui_running")
  syntax enable " enable syntax highlighting
endif

" ====================
" Backups
" ====================
set nobackup      " don't save backup files
set nowritebackup " don't save backup files
set noswapfile    " don't create .swp files
"set backupdir=~/.vim/backup
"set backupcopy=yes

" ====================
" UI
" ====================
set ruler                      " show cursor position, etc.
set showcmd                    " display commands in progress at the bottom
set wildmenu                   " tab completion menu for commands
set wildmode=list:longest,full " tab completion menu options
set number                     " show line numbers

" ====================
" Highlights
" ====================
hi LineNr ctermfg=DarkGray ctermbg=Black
"hi Comment ctermfg=cyan cterm=none
"hi Directory ctermfg=cyan cterm=none
" better git diff colors
hi diffAdded ctermfg=DarkGreen ctermbg=Black
hi diffRemoved ctermfg=DarkRed ctermbg=Black
hi diffFile ctermfg=darkcyan ctermbg=Black

" ====================
" Visual Cues
" ====================
set showmatch                                " show matching brace when closed
set ignorecase                               " ignore case when searching...
set smartcase                                " ...unless a capital letter was typed
set nohlsearch                               " don't highlight search results
set list listchars=trail:.,tab:>.            " highlight trailing whitespace
hi SpecialKey ctermfg=DarkGray ctermbg=Black

" ====================
" Text Formatting
" ====================
set autoindent                  " continue indentation
set smartindent                 " add indentation for code
set backspace=indent,eol,start  " make backspace work correctly
set tabstop=2                   " 2 space tabs, all the time
let &softtabstop=&tabstop
let &shiftwidth=&tabstop
set expandtab
set nosmarttab
set textwidth=110               " wrap text at 110 columns
if exists("+colorcolumn")       " use colorcolumn if supported
  let &colorcolumn = &textwidth
  hi ColorColumn ctermbg=Yellow
endif

" ====================
" Mappings
" ====================
let mapleader=","

" treat moving vertically on a wrapped line as two different lines
nnoremap j gj
nnoremap k gk

" custom shortcuts
nnoremap <LEADER>e :e **/*
nnoremap <LEADER>bb :ls<CR>:b
nnoremap <LEADER>B :b *
nnoremap <LEADER>f :NERDTreeToggle<CR>
nnoremap <LEADER>T :TlistToggle<CR>
nnoremap <LEADER>d :BD<CR>
nnoremap <LEADER>h :set hlsearch!<CR>
nnoremap <LEADER>m :%w ! markdown_doctor \| bcat<CR><CR>
nnoremap <LEADER>s :Sscratch<CR>
nnoremap <LEADER>S :Scratch<CR>

" automatic brace closing
inoremap {<CR>  {<CR>}<Esc>O
inoremap [<CR>  [<CR>]<Esc>O

" underlining
nnoremap <LEADER>= yyp<C-v>$r=
nnoremap <LEADER>- yyp<C-v>$r-

" ====================
" Auto Commands
" ====================
if has("autocmd")
  autocmd BufWinLeave * silent! mkview                     " automatically save folds
  autocmd BufWinEnter * silent! loadview                   " automatically load folds

  autocmd CursorMovedI * if pumvisible() == 0|pclose|endif " close autocomplete preview when cursor moves
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif  " close autocomplete preview on insert mode exit

  autocmd BufWritePre * :%s/\s\+$//e                       " strip trailing whitespace on save

  autocmd BufReadPost *                                    " set cursor to the last position when opening
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif


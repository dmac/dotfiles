" ====================
" Plugins
" ====================
set runtimepath+=~/.vim/bundle/vim-pathogen
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype off " ensure pathogen will pick up plugins with ftdetect directories

" ====================
" Plugin Options
" ====================
let g:SuperTabDefaultCompletionType="context"       " contextual autocomplete
let g:SuperTabContextDefaultCompletionType="<C-n>"  " tab complete forward with autocomplete

let g:NERDTreeChDirMode=2                           " change pwd when NERDTree root changes
let g:NERDChristmasTree=1                           " more colorful NERDTree

" Clojure indentation
let g:clojure_align_multiline_strings = 0
let g:clojure_fuzzy_indent = 1
let g:clojure_fuzzy_indent_patterns = "with.*,def.*,let.*"
let g:clojure_fuzzy_indent_patterns .= ",GET,POST,PUT,PATCH,DELETE"           " Compojure
let g:clojure_fuzzy_indent_patterns .= ",clone-for"                           " Enlive
let g:clojure_fuzzy_indent_patterns .= ",select.*,insert.*,update.*,delete.*" " Korma
let g:clojure_fuzzy_indent_patterns .= ",fact,facts"                          " Midje
let g:clojure_fuzzy_indent_patterns .= ",up,down"                             " Lobos

" Rainbow parentheses
let g:rbpt_colorpairs = [
    \ ['gray',        'DeepPink1'],
    \ ['black',       'pink1'],
    \ ['darkmagenta', 'brown1'],
    \ ['Darkblue',    'chocolate1'],
    \ ['darkred',     'DarkOliveGreen1'],
    \ ['darkgreen',   'DarkOrange1'],
    \ ['darkcyan',    'yellow1'],
    \ ['Darkblue',    'cyan1'],
    \ ['gray',        'PaleGreen1'],
    \ ['black',       'HotPink1'],
    \ ['darkmagenta', 'MediumOrchid'],
    \ ['Darkblue',    'firebrick'],
    \ ['darkred',     'SteelBlue1'],
    \ ['darkgreen',   'goldenrod1'],
    \ ['darkcyan',    'LimeGreen'],
    \ ['Darkblue',    'RoyalBlue1'],
    \ ]

" MacVim has a bug which causes it to have an incorrect $PATH when running commands like ctags or ruby gems.
" To fix it, run `sudo mv /etc/zshenv /etc/zprofile` and initialize rbenv and your PATH in ~/.zprofile.
" See https://github.com/b4winckler/macvim/wiki/Troubleshooting
"     http://vim.1045645.n5.nabble.com/MacVim-and-PATH-td3388705.html
"     https://gist.github.com/2193743
let g:tlist_clojure_settings = 'lisp;f:function'    " Use taglist lisp settings for clojure
let g:Tlist_Exit_OnlyWindow=1                       " Close taglist if it's the only open window

let g:ctrlp_working_path_mode=2                     " Search for files in repository with CtrlP
let g:ctrlp_map = '<LEADER>v'
let g:ctrlp_custom_ignore = '\.git$\|\.DS_Store$'

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
set tags=tags;/           " Search all directoris for tags file
syntax on                 " enable syntax highlighting
filetype plugin indent on " detect filetypes

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
set laststatus=2               " show statusline with filename
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

" ====================
" Mappings
" ====================
let mapleader=","
let maplocalleader=","

" treat moving vertically on a wrapped line as two different lines
nnoremap j gj
nnoremap k gk


" custom shortcuts
nnoremap <LEADER>ev :vsplit $MYVIMRC<CR>
nnoremap <LEADER>sv :source $MYVIMRC<CR>
nnoremap <LEADER>f :NERDTreeToggle<CR>
nnoremap <LEADER>t :TlistToggle<CR>
nnoremap <LEADER>h :set hlsearch!<CR>
nnoremap <LEADER>m :%w ! markdown_doctor \| bcat<CR><CR>
nnoremap <LEADER>cd :cd %:p:h<CR>:pwd<CR>

" delete the current buffer without closing the window
nnoremap <LEADER>d :bp\|bd #<CR>

" underlining
nnoremap <LEADER>= yyp<C-v>$r=
nnoremap <LEADER>- yyp<C-v>$r-

" ====================
" Auto Commands
" ====================
if has("autocmd")
  augroup vimrc
    autocmd!

    autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif   " close autocomplete preview when cursor moves
    autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif    " close autocomplete preview on insert mode exit

    autocmd BufWritePre * :%s/\s\+$//e                         " strip trailing whitespace on save

    autocmd BufReadPost *                                      " set cursor to the last position when opening
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " additional filetypes
    autocmd BufNewFile,BufRead *.ejs set filetype=html
    autocmd BufNewFile,BufRead *.less set filetype=scss
  augroup end

  " Rainbow parentheses
  augroup rainbow_parentheses
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
  augroup end
endif

" ====================
" Colors and Skins
" ====================
if &t_Co > 8
  colorscheme jellybeans
endif
if exists("+colorcolumn")                       " use colorcolumn if supported
  let &colorcolumn = &textwidth
  hi ColorColumn ctermbg=DarkGray guibg=#2D2D2D
endif

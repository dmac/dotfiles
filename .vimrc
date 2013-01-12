runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on


" ------------------------------------------------ General ---------------------------------------------------

set nocompatible                  " duh
set history=1000                  " longer history
set hidden " This allows vim to put buffers in the bg without saving, and then allows undoes when you fg them.
set textwidth=110                 " wrap text at 110 columns
set tabstop=2                     " 2 space tabs, all the time
let &softtabstop=&tabstop
let &shiftwidth=&tabstop
set expandtab
set smarttab
set smartindent                   " add indentation for code
set autoindent                    " continue indentation
set backspace=indent,eol,start    " make backspace work correctly
set incsearch                     " perform search as you type
set nohlsearch                    " don't highlight search results
set ignorecase                    " ignore case when searching...
set smartcase                     " ...unless a capital letter was typed
set showmatch                     " show matching brace when closed
set autoread                      " reload changed files when focus returns
set modeline                      " enable modelines
set number                        " show line numbers
set ruler                         " show cursor position, etc.
set cursorline
set showcmd                       " display commands in progress at the bottom
set cmdheight=1
set laststatus=2                  " show statusline with filename
set wildmenu                      " command tab completion menu
set wildmode=list:longest,full    " command tab completion menu options
set completeopt=longest,menuone   " popup menu completion options
set list listchars=trail:.,tab:>. " highlight trailing whitespace
set tags=tags;/                   " Search all directories for tags file
set nobackup                      " don't save backup files
set nowritebackup                 " don't save backup files
set noswapfile                    " don't create .swp files
set nofoldenable                  " no folds


" ----------------------------------------- Colorscheme and Highlights ---------------------------------------

colorscheme slate2
"colorscheme lucius
"colorscheme jellybeans
if exists("+colorcolumn") " use colorcolumn if supported
  let &colorcolumn = &textwidth + 1
  hi ColorColumn ctermbg=DarkGray guibg=gray15
endif

" Better git diff colors
hi diffAdded ctermfg=DarkGreen ctermbg=Black
hi diffRemoved ctermfg=DarkRed ctermbg=Black
hi diffFile ctermfg=darkcyan ctermbg=Black

" Cursor line highlight
hi CursorLine cterm=NONE ctermbg=NONE guibg=gray20

" Autocomplete menu colors
hi Pmenu ctermbg=black guibg=black
hi PmenuSel ctermfg=black guifg=black


" ----------------------------------------------- Mappings ---------------------------------------------------

let mapleader=","

" treat moving vertically on a wrapped line as two different lines
nnoremap j gj
nnoremap k gk

" custom shortcuts
nnoremap <LEADER>ev :vsplit $MYVIMRC<CR>
nnoremap <LEADER>eg :vsplit $MYGVIMRC<CR>
nnoremap <LEADER>sv :source $MYVIMRC<CR>
nnoremap <LEADER>sg :source $MYGVIMRC<CR>
nnoremap <LEADER>f :NERDTreeToggle<CR>
nnoremap <LEADER>tl :TagbarToggle<CR>
nnoremap <LEADER>h :set hlsearch!<CR>
nnoremap <LEADER>M :%w ! markdown_doctor \| bcat<CR><CR>
nnoremap <LEADER>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <LEADER>m :make<CR><CR>:cwindow<CR>
nnoremap <LEADER>gh :GHCi<SPACE>
nnoremap <LEADER>rp :call RainbowParenthesesReset()<CR>

nnoremap <F2> :autocmd BufEnter handler.clj edit \| set filetype=clojure<CR>

" delete the current buffer without closing the window
nnoremap <LEADER>d :bp\|bd #<CR>

" underlining
nnoremap <LEADER>= yyp<C-v>$r=
nnoremap <LEADER>- yyp<C-v>$r-


" -------------------------------------------- Auto Commands -------------------------------------------------

" Strip trailing whitespace on save
augroup trailing_whitespace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup end

" Additional filetypes
augroup filetypes
  autocmd!
  autocmd BufNewFile,BufRead *.ejs set filetype=html
  autocmd BufNewFile,BufRead *.less set filetype=scss
augroup end

" Restore cursor position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup restore_cursor
  autocmd!
  autocmd BufReadPost * call ResCur()
augroup end

" Activate rainbow parentheses
function! RainbowParenthesesReset()
  RainbowParenthesesToggle
  RainbowParenthesesLoadRound
  RainbowParenthesesLoadSquare
  RainbowParenthesesLoadBraces
endfunction
augroup rainbow_parentheses
  autocmd!
  autocmd VimEnter * RainbowParenthesesToggle
  autocmd Syntax * RainbowParenthesesLoadRound
  autocmd Syntax * RainbowParenthesesLoadSquare
  autocmd Syntax * RainbowParenthesesLoadBraces
augroup end

" -------------------------------------------- Plugin Options ------------------------------------------------

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
let g:rbpt_max = 10
let g:rbpt_colorpairs = [
    \ ['gray',      'HotPink1'],
    \ ['darkred',   'cyan1'],
    \ ['darkcyan',  'brown1'],
    \ ['darkgreen', 'yellow1'],
    \ ['darkblue',  'MediumOrchid'],
    \ ['gray',      'DeepSkyBlue1'],
    \ ['darkred',   'DarkOrange1'],
    \ ['darkcyan',  'LimeGreen'],
    \ ['darkgreen', 'goldenrod1'],
    \ ['darkblue',  'RoyalBlue1'],
    \ ]

let g:haddock_browser = "open"
let g:haskell_conceal = 0      " Don't use unicode characters

" MacVim has a bug which causes it to have an incorrect $PATH when running commands like ctags or ruby gems.
" To fix it, run `sudo mv /etc/zshenv /etc/zprofile` and initialize rbenv and your PATH in ~/.zprofile.
" See https://github.com/b4winckler/macvim/wiki/Troubleshooting
"     http://vim.1045645.n5.nabble.com/MacVim-and-PATH-td3388705.html
"     https://gist.github.com/2193743

let g:ctrlp_working_path_mode=2                     " Search for files in repository with CtrlP
let g:ctrlp_map = '<LEADER>v'
let g:ctrlp_custom_ignore = '\.git$\|\.DS_Store$'

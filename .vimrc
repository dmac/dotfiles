" --------------------------------------------- Vundle / Plugins ---------------------------------------------
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'bitc/lushtags'
Plugin 'bling/vim-airline'
Plugin 'chriskempson/base16-vim'
Plugin 'dag/vim2hs'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'eagletmt/neco-ghc'
Plugin 'fatih/vim-go'
Plugin 'garbas/vim-snipmate'
Plugin 'tomtom/tlib_vim'              " dependency for vim-snipmate
Plugin 'MarcWeber/vim-addon-mw-utils' " dependency for vim-snipmate
Plugin 'guns/vim-clojure-static'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'skammer/vim-css-color'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'wlangstroth/vim-racket'
Plugin 'wting/rust.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-classpath'
Plugin 'cespare/vim-toml'
Plugin 'chase/vim-ansible-yaml'
Plugin 'rking/ag.vim'
Plugin 'dmac/vim-cljfmt'
"Plugin 'file:///Users/dmac/projects/vim-cljfmt'

call vundle#end()
filetype plugin indent on
syntax on

" ------------------------------------------------ General ---------------------------------------------------
set nocompatible                  " duh
set history=1000                  " longer history
set hidden " This allows vim to put buffers in the bg without saving, and then allows undoes when you fg them.
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
set scrolloff=5                   " scroll when 5 lines away from edge of screen
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
set foldlevel=99                  " open all folds by default


" ----------------------------------------- Colorscheme and Highlights ---------------------------------------

set background=dark
colorscheme base16-chalk
if exists("+colorcolumn") " use colorcolumn if supported
  let &colorcolumn = 111
  hi ColorColumn ctermbg=DarkGray guibg=gray15
endif

" Better git diff colors
hi diffAdded ctermfg=DarkGreen ctermbg=Black
hi diffRemoved ctermfg=DarkRed ctermbg=Black
hi diffFile ctermfg=darkcyan ctermbg=Black

" Cursor line highlight
hi CursorLine cterm=NONE ctermbg=NONE guibg=gray20


" ----------------------------------------------- Mappings ---------------------------------------------------

let mapleader=","

" treat moving vertically on a wrapped line as two different lines
nnoremap j gj
nnoremap k gk

" underlining
nnoremap <LEADER>= yyp<C-v>$r=
nnoremap <LEADER>- yyp<C-v>$r-

" custom shortcuts
nnoremap <LEADER>ev :vsplit $MYVIMRC<CR>
nnoremap <LEADER>eg :vsplit $MYGVIMRC<CR>
nnoremap <LEADER>sv :source $MYVIMRC<CR>
nnoremap <LEADER>sg :source $MYGVIMRC<CR>
nnoremap <LEADER>tt :NERDTreeToggle<CR>
nnoremap <LEADER>tl :TagbarToggle<CR>
nnoremap <LEADER>h :set hlsearch!<CR>
nnoremap <LEADER>M :%w ! markdown_doctor \| bcat<CR><CR>
nnoremap <LEADER>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <LEADER>m :make<CR><CR>:cwindow<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

" note taking
nnoremap <LEADER>ne :e ~/Dropbox/notes/
nnoremap <LEADER>ns :Ag  ~/Dropbox/notes<S-Left><Left>

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
  autocmd BufNewFile,BufRead *.yml set filetype=ansible
  autocmd BufNewFile,BufRead *.md set filetype=markdown
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

augroup rainbow_parentheses
  autocmd!
  autocmd Filetype clojure RainbowParenthesesActivate
  autocmd Syntax * RainbowParenthesesLoadRound
  autocmd Syntax * RainbowParenthesesLoadSquare
  autocmd Syntax * RainbowParenthesesLoadBraces
augroup end


" ------------------------------------------ Global Plugin Options -------------------------------------------

" (vim-airline)
let g:airline_powerline_fonts = 1

" (nerdtree)
let g:NERDTreeChDirMode=2                           " change pwd when NERDTree root changes
let g:NERDChristmasTree=1                           " more colorful NERDTree

" (rainbow_parentheses)
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

" (tagbar)
let g:tagbar_iconchars = ['▸', '▾']

" (ctrlp)
let g:ctrlp_map = '<LEADER>f'
let g:ctrlp_working_path_mode=2 " Search for files in repository with CtrlP
let g:ctrlp_custom_ignore = '\.git$\|\.DS_Store$\|.*\.class$'

" (syntastic)
let g:syntastic_always_populate_loc_list = 1

" MacVim has a bug which causes it to have an incorrect $PATH when running commands like ctags or ruby gems.
" To fix it, run `sudo mv /etc/zshenv /etc/zprofile` and initialize rbenv and your PATH in ~/.zprofile.
" See https://github.com/b4winckler/macvim/wiki/Troubleshooting
"     http://vim.1045645.n5.nabble.com/MacVim-and-PATH-td3388705.html
"     https://gist.github.com/2193743


" ---------------------------------------- Language-Specific Options -----------------------------------------
" -- Go --
augroup golang
  autocmd!
  autocmd FileType go setlocal nolist
  autocmd FileType go setlocal tabstop=8
  autocmd FileType go setlocal softtabstop=8
  autocmd FileType go setlocal shiftwidth=8
  autocmd FileType go nnoremap <buffer> <LEADER>F :GoFmt<CR>
  autocmd FileType go nnoremap <buffer> <LEADER>b :GoBuild<CR>
  autocmd FileType go nnoremap <buffer> <LEADER>d :GoDoc<CR>
  autocmd FileType go nnoremap <buffer> <LEADER>i :GoInfo<CR>
  autocmd FileType go nnoremap <buffer> <LEADER>r :GoRun<CR>
augroup END

let g:go_fmt_autosave = 0
let g:go_fmt_command = "goimports"

" -- Clojure --
augroup clojure
  autocmd!
  autocmd FileType clojure nnoremap <buffer> <LEADER>e :%Eval<CR>
  autocmd FileType clojure nnoremap <buffer> <LEADER>E :Eval<CR>
  autocmd FileType clojure nnoremap <buffer> <LEADER>F :CljFmt<CR>
  autocmd FileType clojure setlocal omnifunc=fireplace#omnicomplete
augroup END

let g:ycm_semantic_triggers = {'clojure': ['(']}

" indentation
let g:clojure_align_multiline_strings = 0
let g:clojure_fuzzy_indent = 1
let g:clojure_fuzzy_indent_patterns = "with.*,def.*,let.*,send.*"
let g:clojure_fuzzy_indent_patterns .= ",GET,POST,PUT,PATCH,DELETE,context"   " Compojure
let g:clojure_fuzzy_indent_patterns .= ",clone-for"                           " Enlive
let g:clojure_fuzzy_indent_patterns .= ",select,insert,update,delete,with.*"  " Korma
let g:clojure_fuzzy_indent_patterns .= ",fact,facts"                          " Midje
let g:clojure_fuzzy_indent_patterns .= ",up,down,table"                       " Lobos
let g:clojure_fuzzy_indent_patterns .= ",entity"                              " Custom

" -- Coffeescript --
augroup coffeescript
  autocmd!
  autocmd FileType coffeescript vnoremap <buffer> <LEADER>m :CoffeeCompile {20}<CR>
augroup END

" (tagbar)
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif

" -- Haskell --
augroup haskell
  autocmd!
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
  autocmd FileType haskell setlocal tabstop=4
  autocmd FileType haskell setlocal softtabstop=4
  autocmd FileType haskell setlocal shiftwidth=2
  autocmd FileType haskell nnoremap <buffer> <LEADER>m :GhcModCheckAndLintAsync<CR>
  autocmd BufRead,BufNewFile *.hs call s:set_ghcmod_options()
augroup END

let g:NERD_haskell_alt_style=1 " Use -- for haskell comments
let g:haskell_conceal = 0 " Don't use unicode characters (vim2hs)

" (ghc-mod)
function! s:set_ghcmod_options()
  if !exists('b:ghcmod_ghc_options')
    let b:ghcmod_ghc_options = []
  endif
  if isdirectory("cabal-dev")
    call add(b:ghcmod_ghc_options, '-isrc')
    call add(b:ghcmod_ghc_options, '-i-package-conf'.getcwd().'/cabal-dev/packages-7.4.2.conf')
  endif
endfunction

" -- Python --
augroup python
  autocmd!
  autocmd FileType python setlocal tabstop=4
  autocmd FileType python setlocal softtabstop=4
  autocmd FileType python setlocal shiftwidth=4
augroup END

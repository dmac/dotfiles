" --------------------------------- General ------------------------------------
filetype plugin indent on
syntax on
set nocompatible                  " don't behave like vi
set history=1000                  " longer history
set hidden " allow buffers to be bg'ed without saving and allows undo when fg'ed
set tabstop=2                     " 2 space tabs by default
set softtabstop=2                 " 2 space tabs by default
set shiftwidth=2                  " 2 space tabs by default
set expandtab                     " insert spaces when tab is pressed
set smarttab                      " use shiftwidth when inserting tab
set wrap linebreak                " wrap long lines
set backspace=indent,eol,start    " make backspace work correctly
set incsearch                     " perform search as you type
set nojoinspaces                  " don't join sentences with two spaces
set scrolloff=5                   " scroll when 5 lines away from edge of screen
set ignorecase                    " ignore case when searching...
set smartcase                     " ...unless a capital letter was typed
set autoread                      " reload changed files when focus returns
set showcmd                       " display commands in progress at the bottom
set laststatus=2                  " always show statusline
set wildmenu                      " command tab completion menu
set wildmode=list:longest,full    " command tab completion menu options
set completeopt=longest,menuone   " popup menu completion options
set tags=tags;/                   " Search all directories for tags file
set nobackup                      " don't save backup files
set nowritebackup                 " don't save backup files
set noswapfile                    " don't create .swp files
set foldlevel=99                  " open all folds by default
set clipboard=unnamedplus
set fillchars=fold:-,vert:▏

helptags ALL

" ------------------------------- Statusline -----------------------------------

set statusline=
set statusline+=\ %f " path to file relative to cwd
set statusline+=\ %m " modified flag

set statusline+=%=         " right-align
set statusline+=\%y        " filetype
set statusline+=\ ·\ %p%%  " file percent
set statusline+=\ ·\ %l/%L " line number
set statusline+=\ ·\ %-3c  " column number

" ------------------------------ Colorscheme -----------------------------------

colorscheme dmac-snes-dark
set termguicolors " use gui colors in terminal

if exists("+colorcolumn")
  let &colorcolumn = 81
endif

" ------------------------------- Mappings -------------------------------------

let mapleader=","

" treat moving vertically on a wrapped line as two different lines
nnoremap j gj
nnoremap k gk

" underlining
nnoremap <LEADER>= yyp<C-v>$r=
nnoremap <LEADER>- yyp<C-v>$r-

" global custom shortcuts
nnoremap <LEADER>ev :vsplit $MYVIMRC<CR>
nnoremap <LEADER>eg :vsplit $MYGVIMRC<CR>
nnoremap <LEADER>ec :vsplit $DOTFILES/.vim/colors/dmac-snes-dark.vim<CR>
nnoremap <LEADER>sv :source $MYVIMRC<CR>:e<CR>
nnoremap <LEADER>sg :source $MYGVIMRC<CR>:e<CR>
nnoremap <LEADER>tt :NERDTreeToggle<CR>
nnoremap <LEADER>tl :TagbarToggle<CR>
nnoremap <LEADER>TL :TagbarOpen fj<CR>
nnoremap <LEADER>h :set hlsearch!<CR>
nnoremap <LEADER>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <LEADER>S :echo join(reverse(map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')),' ')<CR>
nnoremap <LEADER>gb :Git blame -w<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" note taking
nnoremap <LEADER>ne :e ~/Dropbox/notes/
nnoremap <LEADER>ns :Ack  ~/Dropbox/notes<S-Left><Left>

let g:ackprg = "rg --vimgrep"

" ------------------------------- Autocommands ---------------------------------

" Strip trailing whitespace on save
augroup trailing_whitespace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup end

" Automatically save changes
augroup autosave
  autocmd!
  autocmd InsertLeave,TextChanged * update
augroup end

" Additional filetypes
augroup filetypes
  autocmd!
  autocmd BufNewFile,BufRead *.h set filetype=c
  autocmd BufNewFile,BufRead *.ejs set filetype=html
  autocmd BufNewFile,BufRead *.less set filetype=scss
  autocmd BufNewFile,BufRead *.yml set filetype=ansible
  autocmd BufNewFile,BufRead *.tpl set filetype=gotexttmpl
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

" -------------------------------- OS Config -----------------------------------
if has('win32')
  let $PYTHONPATH = "C:\\Python27\\Lib;C:\\Python27\\DLLs;C:\\Python27\\Lib\\lib-tk"
  let $CLANG_LIBRARY_PATH="C:\\Program Files (x86)\\LLVM\\bin"
endif

" ----------------------------- Language Options -------------------------------

" -- C/C++ --
let g:clang_library_path = $CLANG_LIBRARY_PATH
let g:clang_complete_macros = 1
let g:clang_complete_auto = 0
let g:clang_sort_algo = "alpha"
let g:clang_jumpto_declaration_key = "gd"
let g:clang_format#auto_format = 1
let g:clang_format#auto_filetypes = ["c", "cpp"]

augroup c
  autocmd!
  autocmd FileType c,cpp setlocal tabstop=4
  autocmd FileType c,cpp setlocal softtabstop=4
  autocmd FileType c,cpp setlocal shiftwidth=4
  autocmd FileType c,cpp setlocal commentstring=//\ %s
  autocmd FileType c,cpp nnoremap <buffer> <LEADER>m :make<CR><CR>:cwindow<CR>
  autocmd FileType c,cpp nnoremap <buffer> <LEADER>M :make<CR>
  autocmd FileType c,cpp nnoremap <buffer> <LEADER>r :make run<CR>
  autocmd FileType c,cpp nnoremap <buffer> <LEADER>g :call SwapHeader()<CR>
  autocmd FileType c,cpp nnoremap <buffer> <LEADER>F :ClangFormat<CR>
augroup END

function! SwapHeader()
  let base = expand("%:r")
  let ext = expand("%:e")
  let fname = ""
  if ext == "c" || ext == "cpp"
    let fname = base.".h"
  elseif ext == "h"
    let list = glob(base.".c*", 0, 1)
    if len(list) > 0
      let fname = list[0]
    endif
  endif
  if findfile(fname) != ""
    execute "edit" fname
  else
    if ext == "h"
      echom base.".c* not found"
    else
      echom fname." not found"
    endif
  endif
endfunction

" -- Go --
let g:go_fmt_autosave = 1
let g:go_fmt_command = "gopls"
let g:go_gopls_local = "liftoff/"
let g:go_gopls_gofumpt = 1
let g:go_search_bin_path_first = 0
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0

augroup go
  autocmd!
  autocmd FileType go setlocal tabstop=8
  autocmd FileType go setlocal softtabstop=8
  autocmd FileType go setlocal shiftwidth=8
  autocmd FileType go nnoremap <buffer> <LEADER>m :GoInstall<CR>
  autocmd FileType go nnoremap <buffer> <LEADER>v :GoVet<CR>
  autocmd FileType go nnoremap <buffer> <LEADER>d :GoDoc<CR>
  autocmd FileType go nnoremap <buffer> <LEADER>i :GoInfo<CR>
  autocmd FileType go nnoremap <buffer> <LEADER>r :GoRun<CR>
  autocmd FileType go nnoremap <buffer> <LEADER>t :GoTest<CR>
augroup END

" -- Clojure --
let g:cljfmt_on_save = 1

augroup clojure
  autocmd!
  autocmd FileType clojure nnoremap <buffer> <LEADER>e :%Eval<CR>
  autocmd FileType clojure nnoremap <buffer> <LEADER>E :Eval<CR>
  autocmd FileType clojure setlocal omnifunc=fireplace#omnicomplete
augroup END

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

" -- Python --
augroup python
  autocmd!
  autocmd FileType python setlocal tabstop=4
  autocmd FileType python setlocal softtabstop=4
  autocmd FileType python setlocal shiftwidth=4
augroup END

" -- Markdown --
augroup markdown
  autocmd!
  autocmd FileType markdown setlocal tabstop=4
  autocmd FileType markdown setlocal softtabstop=4
  autocmd FileType markdown setlocal shiftwidth=4
  autocmd FileType markdown setlocal textwidth=80
  autocmd FileType markdown nnoremap <buffer> <LEADER>m :%w ! markdownd -s<CR><CR>
augroup END

let g:vim_markdown_conceal = 0

" -- Rust --
augroup rust
  autocmd!
  autocmd FileType rust nnoremap <buffer> <LEADER>r :!cargo run<CR>
augroup END

" -- ASM --
augroup asm
  autocmd!
  autocmd FileType asm setlocal commentstring=\;\ %s
augroup END

" -- Git --
augroup git
  autocmd!
  autocmd FileType gitcommit setlocal tabstop=8
  autocmd FileType gitcommit setlocal softtabstop=8
  autocmd FileType gitcommit setlocal shiftwidth=8
augroup END

" -- Zig --
augroup zig
  autocmd!
  autocmd FileType zig nnoremap <buffer> <LEADER>m :compiler zig_build_exe<CR>:make<CR>
  autocmd FileType zig nnoremap <buffer> <LEADER>r :!zig run %<CR>
augroup END

" ------------------------------ Plugin Options --------------------------------

" Disable standard plugin highlighting matching paren.
let g:loaded_matchparen=1

" vim-airline
let g:airline_powerline_fonts=1
let g:airline_theme='base16_grayscale'
let g:airline_section_z='%3p%% • %l/%L • %v'
let g:airline_section_error = ''
let g:airline_section_warning = ''

" Hexokinase
let g:Hexokinase_highlighters = ['background']
let g:Hexokinase_ftEnabled = ['vim', 'css', 'html', 'javascript']
let g:Hexokinase_optInPatterns = ['full_hex', 'triple_hex', 'rgb', 'rgba', 'hsl', 'hsla', 'colour_names']

" nerdtree
let g:NERDChristmasTree=1 " more colorful NERDTree

" tagbar
let g:tagbar_iconchars = ['▸', '▾']

" ctrlp
let g:ctrlp_map = '<LEADER>f'
let g:ctrlp_working_path_mode='r' " Search for files in repository
let g:ctrlp_custom_ignore = '\.git$\|\.DS_Store$\|.*\.class$\|/target/\|/node_modules/\|/MopubSDK/\|/mopub-sdk/\|/vendor/\|/antd/\|/adpreview/\|/cache/'
let g:ctrlp_max_files = 0

" MacVim has a bug which causes it to have an incorrect $PATH when running commands like ctags or ruby gems.
" To fix it, run `sudo mv /etc/zshenv /etc/zprofile` and initialize rbenv and your PATH in ~/.zprofile.
" See https://github.com/b4winckler/macvim/wiki/Troubleshooting
"     http://vim.1045645.n5.nabble.com/MacVim-and-PATH-td3388705.html
"     https://gist.github.com/2193743

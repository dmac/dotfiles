nnoremap <LEADER>e :%Eval<CR>
nnoremap <LEADER>E :Eval<CR>

" Autocompletion
" https://github.com/ervandew/supertab/issues/53
autocmd FileType clojure setlocal omnifunc=fireplace#omnicomplete
let g:SuperTabDefaultCompletionType="<c-x><c-u>"
autocmd FileType clojure
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, '<c-n>') |
    \ endif

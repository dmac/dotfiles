nnoremap <LEADER>e :%Eval<CR>
nnoremap <LEADER>E :Eval<CR>
autocmd FileType clojure setlocal omnifunc=fireplace#omnicomplete

set nolist
set tabstop=8
let &softtabstop=&tabstop
let &shiftwidth=&tabstop

let g:go_fmt_command = "goimports"

nnoremap gi :GoInfo<CR>
nnoremap gr :GoRun<CR>
nnoremap gb :GoBuild<CR>

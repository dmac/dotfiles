setlocal omnifunc=necoghc#omnifunc
setlocal tabstop=4
let &softtabstop=&tabstop
setlocal shiftwidth=2

augroup haskellmode
  autocmd!
  autocmd BufEnter *.hs compiler ghc|set cmdheight=1
augroup end

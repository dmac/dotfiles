setlocal omnifunc=necoghc#omnifunc
setlocal fdl=99 " Open all folds by default
setlocal tabstop=4
let &softtabstop=&tabstop
setlocal shiftwidth=2

augroup haskellmode
  autocmd!
  autocmd BufEnter *.hs compiler ghc|set cmdheight=1
augroup end
